package com.haohuimin.cms.domain;

import com.haohuimin.cms.domain.enums.Desc;

public class Content {
    private Desc desc;
    private String url;
	@Override
	public String toString() {
		return "Content [desc=" + desc + ", url=" + url + "]";
	}
	public Content() {
		super();
	}
	public Content(Desc desc, String url) {
		super();
		this.desc = desc;
		this.url = url;
	}
	public Desc getDesc() {
		return desc;
	}
	public void setDesc(Desc desc) {
		this.desc = desc;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
