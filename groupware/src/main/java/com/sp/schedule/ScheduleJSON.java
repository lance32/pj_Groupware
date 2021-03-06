package com.sp.schedule;

public class ScheduleJSON {
private int id;

private String title;
private String name;
private String color;
private Boolean allDay;
private String start;
private String end;
private String place;
private String content;
private String created;

public String getPlace() {
	return place;
}
public void setPlace(String place) {
	this.place = place;
}

public Boolean getAllDay() {
	return allDay;
}
public void setAllDay(Boolean allDay) {
	this.allDay = allDay;
}

public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getColor() {
	return color;
}
public void setColor(String color) {
	this.color = color;
}

public String getStart() {
	return start;
}
public void setStart(String start) {
	this.start = start;
}
public String getEnd() {
	return end;
}
public void setEnd(String end) {
	this.end = end;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getCreated() {
	return created;
}
public void setCreated(String created) {
	this.created = created;
}

}
