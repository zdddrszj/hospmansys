package cn.com.shxt.util;

import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 * author 张化龙
 * version 2013-5-14
 * description 
 */
public class GetBarJPEG {
	
	/**
	 * version 2013-5-14
	 * description 获取柱状图数据源的方法 
	 * param 需要传递字符串数组作为参数，形如：
	 * {"10,管理人员,管理人员","20,市场人员,市场人员","40,开发人员,开发人员"};
	 * 说明：数组中每个字符串用","隔开三个数据
	 * 第一个数据：柱的高度
	 * 第二个数据：x轴上每个柱子的说明文字
	 * 第三个数据：最下方图例对每个柱子的简要说明
	 */
	public static CategoryDataset createDataset(String[] arr){
		DefaultCategoryDataset  dg = new DefaultCategoryDataset();
		for (String str : arr) {
			String[] subArr = str.split(",");
			dg.setValue(Double.parseDouble(subArr[0]), subArr[1], subArr[2]);
		}
		return dg;
	
	}
	
	public static void getBar(String title,CategoryDataset dataSet,HttpServletRequest request,String x,String y) throws Exception{
		JFreeChart jc = ChartFactory.createBarChart3D(title, x, y,
				dataSet, PlotOrientation.VERTICAL, true, true, false);
		//改变头的内容字体及字体设置
		jc.setTitle(new TextTitle(title,new Font("宋体",Font.BOLD
				+Font.ITALIC,20)));
		//改变中间plot的内容及横纵坐标的字体颜色
		CategoryPlot plot = (CategoryPlot) jc.getPlot();

		CategoryAxis categoryAxis = plot.getDomainAxis();
		NumberAxis numberaxis = (NumberAxis) plot.getRangeAxis();
		
		//设置X轴坐标上的文字    
		categoryAxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 11));     
		//设置X轴的标题文字     
		categoryAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));    
		//设置Y轴坐标上的文字    
		numberaxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 12));     
		//设置Y轴的标题文字     
		numberaxis.setLabelFont(new Font("黑体", Font.PLAIN, 12));    
		//底部汉字乱码的问题     
		jc.getLegend().setItemFont(new Font("宋体", Font.PLAIN, 12));
		

		categoryAxis.setLabelFont(new Font("微软雅黑", Font.BOLD, 12));

		// 以流的形式把jfreechart统计的表格打印成图片存放到硬盘
		String path = request.getSession().getServletContext()
        .getRealPath(File.separator + "chart");
		OutputStream os = new FileOutputStream(path+File.separator+"bar.jpg");
		// 帮助类帮助我们把图标很容易的写进流中从而方便的到硬盘里
		ChartUtilities.writeChartAsJPEG(os, jc, 800, 500);
		
		os.close();
	}
}
