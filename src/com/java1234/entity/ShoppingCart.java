package com.java1234.entity;

import java.util.ArrayList;
import java.util.List;

public class ShoppingCart {

	private int userId;
	private List<ShoppingCartItem> shoppingCartItems=new ArrayList<ShoppingCartItem>();
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public List<ShoppingCartItem> getShoppingCartItems() {
		return shoppingCartItems;
	}
	public void setShoppingCartItems(List<ShoppingCartItem> shoppingCartItems) {
		this.shoppingCartItems = shoppingCartItems;
	}
	
	
}
