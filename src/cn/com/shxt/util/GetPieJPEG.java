package cn.com.shxt.util;

import java.awt.Font;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.general.DefaultPieDataset;

/**
 * author 张化龙
 * version 2013-5-14
 * description 
 */
public class GetPieJPEG {
	/**
	 * version 2013-5-14
	 * description 获取饼图数据源的方法 
	 * param 传递Map参数
	 * Map中的key是比例图中的名称 （String）
	 * Map中的value是比例图中的百分比 （Double）
	 */
	public static DefaultPieDataset getDataset(Map<String,Double> map) {

		DefaultPieDataset dpd = new DefaultPieDataset();

		// 设置数据集一参数为String课动态设置二参数为double为站饼图的比例为多少
		Set<Entry<String,Double>> set = map.entrySet();
		for (Entry<String,Double> entry : set) {
			dpd.setValue(entry.getKey(), entry.getValue());
		}

		return dpd;

	}
	
	public static void getPie(String title,DefaultPieDataset dataSet,HttpServletRequest request) throws Exception{
		JFreeChart jc = ChartFactory.createPieChart3D(title,
				dataSet, true, true, false);
		// 取头
		jc.setTitle(new TextTitle(title, new Font("宋体", Font.BOLD, 22)));

		// 取底部图例 并且取第一个从零开取
		LegendTitle legend = jc.getLegend(0);
		// 设置底部图例的字体类型字体颜色字体大小
		legend.setItemFont(new Font("微软雅黑", Font.BOLD, 14));
		// 取中间plot部分
		PiePlot plot = (PiePlot) jc.getPlot();
		// 设置中间plot部分字体
		plot.setLabelFont(new Font("隶书", Font.BOLD, 16));

		// 以流的形式把jfreechart统计的表格打印成图片存放到硬盘
		String path = request.getSession().getServletContext()
        .getRealPath(File.separator + "chart");
		OutputStream os = new FileOutputStream(path+File.separator+"pie.jpg");
		// 帮助类帮助我们把图标很容易的写进流中从而方便的到硬盘里
		ChartUtilities.writeChartAsJPEG(os, jc, 800, 500);
		
		os.close();
	}
}
