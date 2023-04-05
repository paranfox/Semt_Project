package action;


public class ActionForward {
  private boolean isRedirect;
  
  private String path;
  
  public boolean isRedirect() {
    return this.isRedirect;
  }
  
  public void setRedirect(boolean isRedirect) {
    this.isRedirect = isRedirect;
  }
  
  public String getPath() {
    return this.path;
  }
  
  public void setPath(String path) {
    this.path = path;
  }
}
