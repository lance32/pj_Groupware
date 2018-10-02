package com.sp.mail;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Service("mail.mailService")
public class MailSender {
	// 메일 서버 정보
	private final String SMTPAuthenticatorName = "lance32@naver.com";			// 인증 정보 - 메일 주소
	private final String SMTPAuthenticatorPwd = "";								// 인증 정보 - 비번
	private final String mailSmtpUser = "lance32";								// 사용자
	private final String mailSmtpHost = "smtp.naver.com";						// 메일 서버 주소
	private final String mailSmtpPort = "465";									// 메일 서버 포트
	private final String mailSmtpStarttlsEnable = "465";						// ?
	private final String mailSmtpAuth = "true";									// 인증 사용
	private final String mailSmtpDebug = "true";								// debug
	private final String smtpSocketFactoryPort = "465";
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private FileManager fileManager;
	
	private String mailType;
	private String encType;
	private String pathname;
	
	public MailSender() {
		this.encType = "euc-kr";
		this.mailType = "text/html; charset=euc-kr";
		this.pathname = "c:" + File.separator + "temp" + File.separator + "mail";
	}
	
	public void setMailType(String mailType, String encType) {
		this.mailType = mailType;
		this.encType = encType;
	}
	
	public void setPathname(String pathname) {
		this.pathname = pathname;
	}
	
	private class SMTPAuthenticator extends Authenticator {

		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(SMTPAuthenticatorName, SMTPAuthenticatorPwd);
		}
	}
	
	private void makeMessage(Message msg, Mail mail) throws MessagingException {
		if (mail.getUpload() == null || mail.getUpload().isEmpty()) {
			msg.setText(mail.getContent());
			msg.setHeader("Content-Type", mailType);
		} else {
			MimeBodyPart mbp1 = new MimeBodyPart();
			mbp1.setText(mail.getContent());
			mbp1.setHeader("Content-type", mailType);
			
			Multipart mp = new MimeMultipart();
			mp.addBodyPart(mbp1);
			
//			for (MultipartFile mf : mail.getUpload()) {
//				if (mf.isEmpty())	continue;
				MultipartFile mf = mail.getUpload();
				try {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename != null) {
						//mail.getSavePathname().add(pathname + File.separator + saveFilename);
						mail.setSavePathname(pathname + File.separator + saveFilename);
						String originalFilename = mf.getOriginalFilename();
						MimeBodyPart mbp2 = new MimeBodyPart();
						FileDataSource fds = new FileDataSource(pathname + File.separator + saveFilename);
						mbp2.setDataHandler(new DataHandler(fds));
						
						if (originalFilename == null || originalFilename.length() == 0) 
							mbp2.setFileName(MimeUtility.encodeWord(fds.getName()));
						else 
							mbp2.setFileName(MimeUtility.encodeWord(originalFilename));
						
						mp.addBodyPart(mbp2);
					}
				} catch(UnsupportedEncodingException e) {
					//System.out.println(e.getMessage());
					e.printStackTrace();
				} catch(Exception e) {
//					System.out.println(e.getMessage());
					e.printStackTrace();
				}
			//}
			
			msg.setContent(mp);
		}
	}
	
	public boolean mailSend(Mail mail) throws Exception {
		boolean b = false;
		
		Properties p = new Properties();
		p.put("mail.smtp.user", mailSmtpUser);
		p.put("mail.smtp.host", mailSmtpHost);
		p.put("mail.smtp.port", mailSmtpPort);
		p.put("mail.smtp.starttls.enable", mailSmtpStarttlsEnable);
		p.put("mail.smtp.auth", mailSmtpAuth);
		p.put("mail.smtp.debug", mailSmtpDebug);
		p.put("smtp.socketFactory.port", smtpSocketFactoryPort);
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getDefaultInstance(p, auth);
			session.setDebug(true);
			
			Message msg = new MimeMessage(session);
			
			if (mail.getSendName() == null || mail.getSendName().equals(""))
				msg.setFrom(new InternetAddress(mail.getSendMail()));
			else
				msg.setFrom(new InternetAddress(mail.getSendMail(), mail.getSendName(), encType));
			
			// 받는 사람
			String[] receiveList = mail.getReceiveMail().split(";");
			InternetAddress[] toAddr = new InternetAddress[receiveList.length];
			for (int i = 0; i < receiveList.length; i++) {
				toAddr[i] = new InternetAddress(receiveList[i]);
			}
			msg.setRecipients(Message.RecipientType.TO, toAddr);
			
			// 참조
			String ccList = mail.getCc();
			if (ccList != null && !ccList.isEmpty()) {
				String[] ccMailList = ccList.split(";");
				InternetAddress[] ccAddr = new InternetAddress[ccMailList.length];
				for (int i = 0; i < ccMailList.length; i++) {
					ccAddr[i] = new InternetAddress(ccMailList[i]);
				}
				msg.setRecipients(Message.RecipientType.CC, ccAddr);
			}
			// 숨은 참조
			String bccList = mail.getBcc();
			if (bccList != null && !bccList.isEmpty()) {
				String[] bccMailList = bccList.split(";");
				InternetAddress[] bccAddr = new InternetAddress[bccMailList.length];
				for (int i = 0; i < bccMailList.length; i++) {
					bccAddr[i] = new InternetAddress(bccMailList[i]);
				}
				msg.setRecipients(Message.RecipientType.BCC, bccAddr);
			}
			
			msg.setSubject(mail.getSubject());
			if (mailType.indexOf("text/html") != -1) {
				mail.setContent(myUtil.htmlSymbols(mail.getContent()));
			}
			
			makeMessage(msg, mail);
			msg.setHeader("X-Mailer", mail.getSendName());
			msg.setSentDate(new Date());
			Transport.send(msg);
			
		//	if (mail.getSavePathname() != null && mail.getSavePathname().size() > 0) {
			if (mail.getSavePathname() != null && !mail.getSavePathname().isEmpty()) {
		//		for (String filename : mail.getSavePathname()) {
			//		File file = new File(filename);
					File file = new File(mail.getSavePathname());
					if (file.exists())
						file.delete();
			//	}
			}
			b= true;
		} catch(Exception e) {
			//System.out.println(e.getMessage());
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
		
		return b;
	}
}
