<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
    String saveDirectory = application.getRealPath("/Uploads");
    String originalFilename= request.getParameter("files");
    
    try{
    	File file = new File(saveDirectory, originalFilename);
    	InputStream inStream = new FileInputStream(file);
    	
    	String client = request.getHeader("User-Agent");
    	if(client.indexOf("WOW64")== -1){
    		originalFilename = new String(originalFilename.getBytes("UTF-8"),"ISO-8859-1");
    	}else{
    		originalFilename = new String(originalFilename.getBytes("KSC5601"),"ISO-8859-1");
    	}
    	response.reset();
    	response.setContentType("application/octet-stream");
    	response.setHeader("Content-Disposition", "attachment; filename=\""+originalFilename+"\"");
    	response.setHeader("Content-Length", ""+file.length());
    	
    	OutputStream outStream= response.getOutputStream();
    	out.clear();
    	out= pageContext.pushBody();
    	
    	byte b[]= new byte[(int)file.length()];
    	int readBuffer = 0;
    	while((readBuffer =inStream.read(b))>0){
    		outStream.write(b,0,readBuffer);
    	}
    	inStream.close();
    	outStream.close();
    	
    	
    }catch(FileNotFoundException e){
		JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
    }
    catch(Exception e ){
    	JSFunction.alertBack("예외발생", out);
    }
    %>
<!DOCTYPE html>
