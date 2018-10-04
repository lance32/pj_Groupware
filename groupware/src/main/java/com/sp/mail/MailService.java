package com.sp.mail;

import java.util.List;
import java.util.Map;

public interface MailService {
	public void insertMail(Mail dto);
	public Mail readMail(long index);
	public List<Mail> list(Map<String, Object> map);
	public void updateMail(Mail dto);
	public void updateMail(long index, int state);
	public void deleteMail(long index);
	public long dataCount(Map<String, Object> map);
}
