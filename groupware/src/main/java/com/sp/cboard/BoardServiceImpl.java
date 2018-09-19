package com.sp.cboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("cboard.boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertBoard(Board dto, String mode, String pathname) {
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("tableName", dto.getTableName());
			
			if(mode.equals("created")) {
				int maxNum = dao.selectOne("cboard.maxNum", map);
				dto.setNum(maxNum+1);
				dto.setGroupNum(dto.getNum());
			} else if(mode.equals("answer")) {
				// 일반 글이 아닌 답변일 경우 작성 필요
				map.put("tableName", dto.getTableName());
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("cboard.updateOrderNo", map);
				
				int maxNum = dao.selectOne("cboard.maxNum", map);
				dto.setNum(maxNum+1);
				dto.setDepth(dto.getDepth()+1);
				dto.setOrderNo(dto.getOrderNo()+1);
			}
			result = dao.insertData("cboard.insertBoard", dto);
			
			// 파일 업로드
			if(dto.getUpload() != null && ! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename != null) {
						String originalFilename = mf.getOriginalFilename();
						long fileSize = mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("cboard.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;
		try {
			list = dao.selectList("cboard.listBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int updateHitCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.updateData("cboard.updateHitCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Board readBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("cboard.readBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("cboard.preReadBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("cboard.nextReadBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateBoard(Board dto, String pathname) {
		int result = 0;
		try {
			result = dao.updateData("cboard.updateBoard", dto);
			if(dto.getUpload() != null && ! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					if(mf.isEmpty())
						continue;
					
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename!=null) {
						String originalFilename=mf.getOriginalFilename();
						long fileSize=mf.getSize();
						
						dto.setOriginalFilename(originalFilename);
						dto.setSaveFilename(saveFilename);
						dto.setFileSize(fileSize);
						
						insertFile(dto);
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteBoard(Map<String, Object> map) {
		int result=0;
		try {
			// 파일 지우기
			String pathname=(String)map.get("pathname");
			
			List<Board> listFile=listFile(map);
			if(listFile != null) {
				for(Board dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			// 파일 테이블 내용 지우기
			// 정확히 이해 안됨
			map.put("field", "num");
			deleteFile(map);
			
			result=dao.deleteData("cboard.deleteBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertBoardLike(Board dto) {
		int result = 0;
		try {
			result = dao.insertData("cboard.insertBoardLike", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int boardLikeCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("cboard.boardLikeCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertFile(Board dto) {
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("tableName", dto.getTableName());
			
			int maxFileNum = dao.selectOne("cboard.maxFileNum", map);
			dto.setFileNum(maxFileNum+1);
			
			result = dao.insertData("cboard.insertFile", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Board> listFile(Map<String, Object> map) {
		List<Board> listFile = null;
		try {
			listFile = dao.selectList("cboard.listFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return listFile;
	}

	@Override
	public Board readFile(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("cboard.readFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int deleteFile(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.deleteData("cboard.deleteFile", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

	@Override
	public int insertReply(Reply dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Reply> listReplyAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int replyAnswerCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertReplyLike(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
