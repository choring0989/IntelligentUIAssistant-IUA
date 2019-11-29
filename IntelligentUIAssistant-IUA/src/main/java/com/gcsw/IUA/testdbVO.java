package com.gcsw.IUA;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;


public class testdbVO {
	
	private String key;
	private Object values;
	
	public testdbVO(String key, Object values) {
		super();
		this.key = key;
		this.values = values;
	}
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public Object getValues() {
		return values;
	}
	public void setValues(Object values) {
		this.values = values;
	}
}
