package com.sp.mail;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service(value = "mail.service")
public class MailServiceImpl implements MailService {
	@Autowired
	private MongoOperations mongo;
	
	@Override
	public void insertMail(Mail dto) {
		try {
			Query query = new Query();
			query.with(new Sort(Sort.Direction.DESC, "index"));
			query.fields().include("index");		// index만 불러옴
			Mail lastMail = mongo.findOne(query, Mail.class);
			
			long index = 1;
			if (lastMail != null)
				index = lastMail.getIndex() + 1;
			
			dto.setIndex(index);
			dto.setSendTime(new Date());
			mongo.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Mail readMail(long index) {
		Mail mail = null;
		try {
			Query query = new Query();
			query.fields().include("index");
			query.fields().include("memberNum");
			query.fields().include("receiveMail");
			query.fields().include("sendMail");
			query.fields().include("sendName");
			query.fields().include("subject");
			query.fields().include("content");
			query.fields().include("cc");
			query.fields().include("bcc");
			query.fields().include("sendTime");
			query.fields().include("state");
			query.addCriteria(Criteria.where("index").is(index));
			mail = mongo.findOne(query, Mail.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mail;
	}

	@Override
	public List<Mail> list(String memberNum) {
		List<Mail> list = null;
		try {
			Query query = new Query();
			query.fields().include("index");
			query.fields().include("memberNum");
			query.fields().include("receiveMail");
			query.fields().include("sendMail");
			query.fields().include("sendName");
			query.fields().include("subject");
			query.fields().include("content");
			query.fields().include("sendTime");
			query.fields().include("state");
			// 페이징 & search 처리 필요
			query.limit(10);
			query.addCriteria(Criteria.where("memberNum").is(memberNum)); //.andOperator(Criteria.where("").is("")));
			list = mongo.find(query, Mail.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateMail(Mail mail) {
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("index").is(mail.getIndex()));
			
			Update update = new Update();
			update.set("memberNum", mail.getMemberNum());
			update.set("receiveMail", mail.getReceiveMail());
			update.set("sendMail", mail.getSendMail());
			update.set("sendName", mail.getSendName());
			update.set("subject", mail.getSubject());
			update.set("content", mail.getContent());
			update.set("cc", mail.getCc());
			update.set("bcc", mail.getBcc());			
			update.set("sendTime", mail.getSendTime());
			update.set("state", mail.getState());
			
			mongo.updateFirst(query, update, Mail.class);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateMail(long index, int state) {
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("index").is(index));
			
			Update update = new Update();
			update.set("state", state);
			
			mongo.updateFirst(query, update, Mail.class);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void deleteMail(long index) {
		try {
			Query query = new Query();
			query.addCriteria(Criteria.where("index").is(index));
			
			Mail mail = mongo.findOne(query, Mail.class);
			mongo.remove(mail);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public long dataCount(Map<String, Object> map) {
		long result = 0;
		try {
			String memberNum = (String)map.get("memberNum");
			Criteria memNum = Criteria.where("memberNum").is(memberNum);
			Query query = new Query();
			
			String searchValue = (String)map.get("searchValue");
			if (searchValue == null || searchValue.isEmpty()) {
				query.addCriteria(Criteria.where("memberNum").is(memberNum));
			} else { 
				if (map.get("searchKey").equals("all")) {
					Criteria subject = Criteria.where("subject").is(searchValue);
					Criteria content = Criteria.where("content").is(searchValue);
					Criteria receive = Criteria.where("receiveMail").is(searchValue);
					query.addCriteria(new Criteria().orOperator(subject, content, receive).andOperator(memNum));
				} else if (map.get("searchKey").equals("subject")) {
					query.addCriteria(Criteria.where("subject").is(searchValue).andOperator(memNum));
				} else if (map.get("searchKey").equals("content")) {
					query.addCriteria(Criteria.where("content").is(searchValue).andOperator(memNum));
				} else if (map.get("searchKey").equals("receiveMail")) {
					query.addCriteria(Criteria.where("receiveMail").is(searchValue).andOperator(memNum));
				}
			}
			result = mongo.count(query, Mail.class);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Mail> list(Map<String, Object> map) {
		List<Mail> list = new ArrayList<Mail>();
		
		try {
			String memberNum = (String)map.get("memberNum");
			Criteria memNum = Criteria.where("memberNum").is(memberNum);
			Query query = new Query();
			
			String searchValue = (String)map.get("searchValue");
			if (searchValue == null || searchValue.isEmpty()) {
				query.addCriteria(Criteria.where("memberNum").is(memberNum));
			} else { 
				if (map.get("searchKey").equals("all")) {
					Criteria subject = Criteria.where("subject").is(searchValue);
					Criteria content = Criteria.where("content").is(searchValue);
					Criteria receive = Criteria.where("receiveMail").is(searchValue);
					query.addCriteria(new Criteria().orOperator(subject, content, receive).andOperator(memNum));
				} else if (map.get("searchKey").equals("subject")) {
					query.addCriteria(Criteria.where("subject").is(searchValue).andOperator(memNum));
				} else if (map.get("searchKey").equals("content")) {
					query.addCriteria(Criteria.where("content").is(searchValue).andOperator(memNum));
				} else if (map.get("searchKey").equals("receiveMail")) {
					query.addCriteria(Criteria.where("receiveMail").is(searchValue).andOperator(memNum));
				}
			}
			//query.skip(map.get("page")).limit(map.get("rows"));
			list = mongo.find(query, Mail.class);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
