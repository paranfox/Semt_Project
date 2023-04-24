package action;


import action.ActionForward;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
  ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
