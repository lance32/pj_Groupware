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
import org.springframework.web.multipart.MultipartFile;

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
			// Mail 첨부파일 처리가 아직 안됨.(List<String> savePathname, List<MultipartFile> upload) 
			dto.setSavePathname(null);
			dto.setUpload(null);
			// ---------------------------------------
			
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
			query.fields().include("index");
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
			int state = (int)map.get("state");
			Criteria stateCriteria = Criteria.where("state").is(state);
			Query query = new Query();
			
			String searchValue = (String)map.get("searchValue");

			if (searchValue == null || searchValue.isEmpty()) {
				query.addCriteria(Criteria.where("memberNum").is(memberNum).andOperator(stateCriteria));
			} else { 
				if (map.get("searchKey").equals("all")) {
					Criteria subject = Criteria.where("subject").regex(searchValue);
					Criteria content = Criteria.where("content").regex(searchValue);
					Criteria receive = Criteria.where("receiveMail").regex(searchValue);
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, new Criteria().orOperator(subject, content, receive)));
				} else if (map.get("searchKey").equals("subject")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("subject").regex(searchValue)));
				} else if (map.get("searchKey").equals("content")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("content").regex(searchValue)));
				} else if (map.get("searchKey").equals("receiveMail")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("receiveMail").regex(searchValue)));
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
			int state = (int)map.get("state");
			Criteria stateCriteria = Criteria.where("state").is(state);
			
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
			
			String searchValue = (String)map.get("searchValue");
			if (searchValue == null || searchValue.isEmpty()) {
				query.addCriteria(Criteria.where("memberNum").is(memberNum).andOperator(stateCriteria));
			} else { 
				if (map.get("searchKey").equals("all")) {
					Criteria subject = Criteria.where("subject").regex(searchValue);
					Criteria content = Criteria.where("content").regex(searchValue);
					Criteria receive = Criteria.where("receiveMail").regex(searchValue);
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, new Criteria().orOperator(subject, content, receive)));
				} else if (map.get("searchKey").equals("subject")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("subject").regex(searchValue)));
				} else if (map.get("searchKey").equals("content")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("content").regex(searchValue)));
				} else if (map.get("searchKey").equals("receiveMail")) {
					query.addCriteria(new Criteria().andOperator(memNum, stateCriteria, Criteria.where("receiveMail").regex(searchValue)));
				}
			}
			
			int start = (int)map.get("start") - 1;
			int end = (int)map.get("end");
			query.skip(start).limit(end - start);
			query.with(new Sort(Sort.Direction.DESC, "index"));

			list = mongo.find(query, Mail.class);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
