package com.sp.clubBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("clubBoard.clubBoardService")
public class ClubBoardServiceImpl implements ClubBoardService{
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public int insertClubBoard(Board dto, String pathname) {
		int result=0;
		try {
			if(dto.getUpload()!=null && ! dto.getUpload().isEmpty()) {
				String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
				dto.setSaveFileName(saveFilename);
				dto.setOriginalFileName(dto.getUpload().getOriginalFilename());
			}
			dao.insertData("clubBoard.insertClubBoard", dto);
			result =1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Board> listClubBoard(Map<String, Object> map) {
		List<Board> list=null;
		try {
			list=dao.selectList("clubBoard.listClubBoard", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int deleteClubBoard(int boardNum, String saveFilename, String pathname) {
		int result=0;
		try {
			if(saveFilename != null ) {
				fileManager.doFileDelete(saveFilename, pathname);
			}
			dao.deleteData("clubBoard.deleteClubBoard", boardNum);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public Board readClubBoard(int boardNum) {
		Board dto=null;
		try {
			dto=dao.selectOne("clubBoard.readClubBoard", boardNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	@Override
	public int updateClubBoard(Board dto, String pathname, String isDeleteFile) {
		int result=0;
		try {
			if(isDeleteFile.equals("false")) {
				dao.updateData("clubBoard.updateClubBoard", dto);
			}else if(isDeleteFile.equals("true") || isDeleteFile.equals("none")){
				// 이전파일 지우기
				if(dto.getSaveFileName().length()!=0 && dto.getSaveFileName()!=null) {
					fileManager.doFileDelete(dto.getSaveFileName(), pathname);
				}
				//새로운 파일을 추가함
				if(dto.getUpload()!=null && !dto.getUpload().isEmpty()) {
					String newFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
					if (newFilename != null) {
						dto.setOriginalFileName(dto.getUpload().getOriginalFilename());
						dto.setSaveFileName(newFilename);
					}
				//새로운 파일을 추가 안함
				}else {
					dto.setSaveFileName("");
					dto.setOriginalFileName("");
			    }
				dao.updateData("clubBoard.updateClubBoard_withFile", dto);
			}
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	
	@Override
	public int insertReply(Reply dto) {
		int result=0;
		try {
			dao.insertData("clubBoard.insertReply", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list=null;
		try {
			list=dao.selectList("clubBoard.listReply", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("clubBoard.replyCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int deleteReply(int replyNum) {
		int result=0;
		try {
			result=dao.deleteData("clubBoard.deleteReply", replyNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public int insertReplyAnswer(Reply dto) {
		int result=0;
		try {
			System.out.println("insertReplyAnswer며럊더러ㅑㄷ");
			dao.insertData("clubBoard.insertReplyAnswer", dto);
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list =null;
		try {
			list=dao.selectList("clubBoard.listReplyAnswer", answer);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}

}
