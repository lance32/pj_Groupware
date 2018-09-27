package com.sp.mail;

import java.util.List;

public interface MailService {
	public void insertMail(Mail dto);
	public Mail readMail(long index);
	public List<Mail> list();
	public void updateMail(Mail dto);
	public void deleteMail(long index);
}
