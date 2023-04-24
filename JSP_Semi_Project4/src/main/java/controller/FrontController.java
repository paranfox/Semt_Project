package controller;

import action.Action;
import action.ActionForward;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Properties;
import java.util.StringTokenizer;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String uri = request.getRequestURI();
		System.out.println("uri >>> " + uri);

		String path = request.getContextPath();
		System.out.println("Path >>> " + path);

		String command = uri.substring(path.length() + 1);
		
		if(command.contains("/")) {
			StringTokenizer st1 = new StringTokenizer(command, "/");
			String url_1 = st1.nextToken();
			command = st1.nextToken();
		}
		System.out.println("Command >>> " + command);

		
		Action action = null;
		ActionForward forward = null;
		Properties prop = new Properties();
		
		String path2 = FrontController.class.getResource("").getPath();
        //System.out.println("path2 >>> "+path2);
        FileInputStream fis = new FileInputStream(path2 + "mapping.properties");
		

		prop.load(fis);

		String value = prop.getProperty(command);
		System.out.println("value >>> " + value);

		if (value.substring(0, 7).equals("execute")) {
			StringTokenizer st = new StringTokenizer(value, "|");
			String url_1 = st.nextToken();
			String url_2 = st.nextToken();

			try {
				Class<?> url = Class.forName(url_2);
				Constructor<?> constructor = url.getConstructor(new Class[0]);
				action = (Action) constructor.newInstance(new Object[0]);
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath(value);
		}

		if (forward != null)
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
				rd.forward((ServletRequest) request, (ServletResponse) response);
			}
	}
}