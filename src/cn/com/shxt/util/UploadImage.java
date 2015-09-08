package cn.com.shxt.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

public class UploadImage {
	public static Map<String,Object> getUpload(HttpServletRequest request){
		
		/* 定义一个map存储request对象中传递的 */
		Map<String,Object> map = new HashMap<String,Object>();
		
		/* 获得上传文件目标目录的真实路径 */
		String path = request.getSession().getServletContext().getRealPath(File.separator+"upload");
		
		/* 判断目录是否存在，不存在则创建一个 */
		File forlder = new File(path);
		if(!forlder.exists()){
			forlder.mkdir();
		}
		
		/* 1.获得请求是否是文件上传类型，如果是，则进行文件上传 */
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart){
			/* 2.创建磁盘文件条目工厂 */
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			/* 3.创建ServletFileUpload实例 */
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			/* 设置单个文件上传不超过5M */
			upload.setFileSizeMax(5*1024*1024);
			
			/* 创建输入输出流对象 */
			InputStream in = null ;
			OutputStream out = null;
			try{
				/* 4.解析请求中所有的表单项，返回一个迭代器 */
				FileItemIterator it = upload.getItemIterator(request);
				
				/* 5.遍历迭代器 */
				while(it.hasNext()){
					FileItemStream item = it.next();// 获得每个表单数据的流对象
					
					String name = item.getFieldName();//获得表单项中的name 
					in = item.openStream();
					
					/* 判断是否是普通表单 */
					if(item.isFormField()){
						/* 存储普通表单的内容 */
						map.put(name, Streams.asString(in,"UTF-8"));
						
					}else{
						/* 上传文件 */
						/* 获得上传的文件的文件名 */
						String fileName = "";
						int start = item.getName().lastIndexOf(".");// 获得最后一个反斜杠的位置
						if(start > 0){
							fileName = item.getName().substring(start);
							//System.out.println(fileName);
						}else{
							fileName = item.getName();
						}
						if(fileName!=""){
							String saveName = new Date().getTime()+fileName;// 生成要保存的文件名称
							out = new FileOutputStream(new File(path,saveName));// 创建输出流对象
							map.put("saveName", saveName);
							
							// 将输入流里的内容写入到输出流中，目的是在程序上下文的upload文件夹中创建用户上传的文件
							// 流的输入输出 要借助于缓冲区，即使用字节数组,1024为缓冲区大小-->1024byte
							byte[] buf = new byte[1024];
							int length ;// length代表读取的字节数量
							while((length=in.read(buf))>0){
								out.write(buf,0,length);
							}
						}else{
							map.put("saveName", "");
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				if(out != null){
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				if(in != null){
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return map;
	} 
}
