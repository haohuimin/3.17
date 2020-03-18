package com.haohuimin.cms.domain.enums;

public enum Gender {

	//定义常量
	MAN("男"),
	WOMAN("女");
	//封装私有属性
	private String displayName;
	
	public String getDisplayName() {
		return displayName;
	}
	//有参数的构造

	private Gender(String displayName) {
		this.displayName = displayName;
	}
	//提高一个获得常量的方法
	public String getName() {
		return this.name();
	}
	//提供一个过的下标的方法
	public int getOrdinal() {
		return this.ordinal();
	}
	
}
