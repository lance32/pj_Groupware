package com.sp.mail;

public class MailServerInfo {
	private String smtpAuthenticatorName;		// 인증 정보 - 메일 주소
	private String smtpAuthenticatorPwd;		// 인증 정보 - 비번
	private String mailSmtpUser;				// 사용자
	private String mailSmtpHost;				// 메일 서버 주소
	private String mailSmtpPort;				// 메일 서버 포트
	private String mailSmtpStarttlsEnable;		// ?
	private String mailSmtpAuth;				// 인증 사용
	private String mailSmtpDebug;				// debug
	private String smtpSocketFactoryPort;
	private String type;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSmtpAuthenticatorName() {
		return smtpAuthenticatorName;
	}
	public void setSmtpAuthenticatorName(String smtpAuthenticatorName) {
		this.smtpAuthenticatorName = smtpAuthenticatorName;
	}
	public String getSmtpAuthenticatorPwd() {
		return smtpAuthenticatorPwd;
	}
	public void setSmtpAuthenticatorPwd(String smtpAuthenticatorPwd) {
		this.smtpAuthenticatorPwd = smtpAuthenticatorPwd;
	}
	public String getMailSmtpUser() {
		return mailSmtpUser;
	}
	public void setMailSmtpUser(String mailSmtpUser) {
		this.mailSmtpUser = mailSmtpUser;
	}
	public String getMailSmtpHost() {
		return mailSmtpHost;
	}
	public void setMailSmtpHost(String mailSmtpHost) {
		this.mailSmtpHost = mailSmtpHost;
	}
	public String getMailSmtpPort() {
		return mailSmtpPort;
	}
	public void setMailSmtpPort(String mailSmtpPort) {
		this.mailSmtpPort = mailSmtpPort;
	}
	public String getMailSmtpStarttlsEnable() {
		return mailSmtpStarttlsEnable;
	}
	public void setMailSmtpStarttlsEnable(String mailSmtpStarttlsEnable) {
		this.mailSmtpStarttlsEnable = mailSmtpStarttlsEnable;
	}
	public String getMailSmtpAuth() {
		return mailSmtpAuth;
	}
	public void setMailSmtpAuth(String mailSmtpAuth) {
		this.mailSmtpAuth = mailSmtpAuth;
	}
	public String getMailSmtpDebug() {
		return mailSmtpDebug;
	}
	public void setMailSmtpDebug(String mailSmtpDebug) {
		this.mailSmtpDebug = mailSmtpDebug;
	}
	public String getSmtpSocketFactoryPort() {
		return smtpSocketFactoryPort;
	}
	public void setSmtpSocketFactoryPort(String smtpSocketFactoryPort) {
		this.smtpSocketFactoryPort = smtpSocketFactoryPort;
	}
}
