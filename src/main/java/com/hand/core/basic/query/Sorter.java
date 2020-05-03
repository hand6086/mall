package com.hand.core.basic.query;

import java.io.Serializable;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Sorter  implements Serializable{
	private static final Logger logger = LogManager.getLogger(Sorter.class);
	private static final long serialVersionUID = -4278387755112165274L;
	public static String DIR_ASC = "ASC";
	public static String DIR_DESC = "DESC";
	
	private String id;
	private String property;
	private String direction = DIR_ASC;
	
	public Sorter(){
		
	}
	
	public Sorter(String id ,String property, String direction){
		this.id = id;
		this.property = property;
		this.direction = direction;
	}
	
	public Sorter(String property, String direction){
		this.property = property;
		this.direction = direction;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProperty() {
		return property;
	}
	public void setProperty(String property) {
		this.property = property;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	

	@Override
	public boolean equals(Object obj){
		if(obj == null || obj.getClass() != this.getClass()){
			return false;
		}else{
			//如果id一致，则相等否则property  一致 Sorter则相等
			Sorter sorterObj = (Sorter)obj;
			if(sorterObj.getId() != null && sorterObj.getId().equals(this.id)) return true;
			if(sorterObj.getProperty()!=null && sorterObj.getProperty().equalsIgnoreCase(this.property)){
				if(sorterObj.getDirection()!=null && sorterObj.getDirection().equalsIgnoreCase(this.direction)){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}
	}
	
	public boolean equalsWithoutDirection(Object obj){
		if(obj == null || obj.getClass() != this.getClass()){
			return false;
		}else{
			//如果id一致，则相等否则property  一致 Sorter则相等
			Sorter sorterObj = (Sorter)obj;
			if(sorterObj.getId() != null && sorterObj.getId().equals(this.id)) return true;
			if(sorterObj.getProperty()!=null && sorterObj.getProperty().equalsIgnoreCase(this.property)){
				return true;
			}else{
				return false;
			}
		}
	}
	
	@Override
    public int hashCode() {
	
        int hash = 17;
        hash = hash * 31 + (id == null ? 0 : id.hashCode());
        hash = hash * 31 + (property == null ? 0 : property.hashCode());
        hash = hash * 31 + (direction == null ? 0 : direction.hashCode());
        return hash;
    }
	
	@Override
	public Sorter clone(){
		Sorter sorter = new Sorter(id,property,direction);
		return sorter;
	}
	
	@Override
	public String toString(){
		StringBuilder sb = new StringBuilder("{");
		sb.append("id : "+id).append(",");
		sb.append("property : "+property).append(",");
		sb.append("direction : "+direction);
		sb.append("}");
		return sb.toString();
	}
}
