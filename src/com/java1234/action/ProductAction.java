package com.java1234.action;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Controller;

import com.java1234.entity.PageBean;
import com.java1234.entity.Product;
import com.java1234.entity.ProductBigType;
import com.java1234.entity.ProductSmallType;
import com.java1234.entity.User;
import com.java1234.service.ProductService;
import com.java1234.util.DateUtil;
import com.java1234.util.NavUtil;
import com.java1234.util.PageUtil;
import com.java1234.util.ResponseUtil;
import com.java1234.util.StringUtil;
import com.opensymphony.xwork2.ActionSupport;

@Controller
public class ProductAction extends ActionSupport implements ServletRequestAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Resource
	private ProductService productService;
	
	private HttpServletRequest request;
	
	private List<Product> productList;
	private Product s_product;
	
	private String page;
	private String rows;
	private Long total;
	private String pageCode;
	private String mainPage;
	private String navCode;
	
	private int productId;
	private Product product;
	
	private String ids;
	
	
	
	
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}
	public List<Product> getProductList() {
		return productList;
	}
	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}
	public Product getS_product() {
		return s_product;
	}
	public void setS_product(Product s_product) {
		this.s_product = s_product;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public String getPageCode() {
		return pageCode;
	}
	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}
	public String getMainPage() {
		return mainPage;
	}
	public void setMainPage(String mainPage) {
		this.mainPage = mainPage;
	}
	public String getNavCode() {
		return navCode;
	}
	public void setNavCode(String navCode) {
		this.navCode = navCode;
	}
	
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	
	private File proPic;
	private String proPicFileName;
	
	
	public File getProPic() {
		return proPic;
	}
	public void setProPic(File proPic) {
		this.proPic = proPic;
	}
	public String getProPicFileName() {
		return proPicFileName;
	}
	public void setProPicFileName(String proPicFileName) {
		this.proPicFileName = proPicFileName;
	}
	@Override
	public String execute() throws Exception {
		if(StringUtil.isEmpty(page)){
			page="1";
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),8);
		productList=productService.findProductList(s_product, pageBean);
		total=productService.getProductCount(s_product);
		StringBuffer param=new StringBuffer();
		if(s_product!=null){
			if(s_product.getBigType()!=null){
				param.append("s_product.bigType.id="+s_product.getBigType().getId());
			}
			if(s_product.getSmallType()!=null){
				param.append("s_product.smallType.id="+s_product.getSmallType().getId());
			}
			if(StringUtil.isNotEmpty(s_product.getName())){
				param.append("s_product.name="+s_product.getName());
			}
		}
		pageCode=PageUtil.genPagination(request.getContextPath()+"/product.action", total, Integer.parseInt(page), 8, param.toString());
		navCode=NavUtil.genNavCode("商品列表");
		mainPage="product/productList.jsp";
		return super.execute();
	}
	
	public String showProduct()throws Exception{
		product=productService.getProductById(productId);
		saveCurrentBrowse(product);
		navCode=NavUtil.genNavCode("商品详情");
		mainPage="product/productDetails.jsp";
		return SUCCESS;
	}
	
	private void saveCurrentBrowse(Product product)throws Exception{
		HttpSession session=request.getSession();
		List<Product> currentBrowseProduct=(List<Product>) session.getAttribute("currentBrowse");
		if(currentBrowseProduct==null){
			currentBrowseProduct=new LinkedList<Product>();
		}
		
		boolean flag=true;
		for(Product p:currentBrowseProduct){
			if(p.getId()==product.getId()){
				flag=false;
				break;
			}
		}
		
		if(flag){
			currentBrowseProduct.add(0,product);
		}
		
		if(currentBrowseProduct.size()==5){
			currentBrowseProduct.remove(4);
		}
		
		session.setAttribute("currentBrowse", currentBrowseProduct);
	}
	
	public String list()throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		List<Product> productList=productService.findProductList(s_product, pageBean);
		long total=productService.getProductCount(s_product);
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"orderProductList"});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		jsonConfig.registerJsonValueProcessor(ProductBigType.class,new ObjectJsonValueProcessor(new String[]{"id","name"}, ProductBigType.class));
		jsonConfig.registerJsonValueProcessor(ProductSmallType.class,new ObjectJsonValueProcessor(new String[]{"id","name"}, ProductSmallType.class));
		JSONArray rows=JSONArray.fromObject(productList, jsonConfig);
		JSONObject result=new JSONObject();
		result.put("rows", rows);
		result.put("total", total);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	public String save()throws Exception{
		if(proPic!=null){
			String imageName=DateUtil.getCurrentDateStr();
			String realPath=ServletActionContext.getServletContext().getRealPath("/images/product");
			String imageFile=imageName+"."+proPicFileName.split("\\.")[1];
			File saveFile=new File(realPath,imageFile);
			FileUtils.copyFile(proPic, saveFile);
			product.setProPic("images/product/"+imageFile);
		}else if(StringUtil.isEmpty(product.getProPic())){
			product.setProPic("");
		}
		productService.saveProduct(product);
		JSONObject result=new JSONObject();
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	
	public String delete()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			Product product=productService.getProductById(Integer.parseInt(idsStr[i]));
			productService.deleteProduct(product);
		}
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	public String setProductWithHot()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			productService.setProductWithHot(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	public String setProductWithSpecialPrice()throws Exception{
		JSONObject result=new JSONObject();
		String []idsStr=ids.split(",");
		for(int i=0;i<idsStr.length;i++){
			productService.setProductWithSpecialPrice(Integer.parseInt(idsStr[i]));
		}
		result.put("success", true);
		ResponseUtil.write(ServletActionContext.getResponse(), result);
		return null;
	}
	
	
	@Override
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
	
	
	
}
