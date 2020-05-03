package com.hand.base.user.authority;

import org.springframework.beans.factory.annotation.Autowired;

import com.hand.base.user.service.LoginService;  
  
public  class AuthorInterceptor /*extends AbstractPhaseInterceptor<SoapMessage>*/{  
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private UserPasswordEncoder userPasswordEncoder;
  
    
    
   /* public  AuthorInterceptor() {  
          super(Phase.PRE_PROTOCOL);  
          getAfter().add(SAAJInInterceptor.class.getName());  
         }  */
       
      
      
    /* public void handleMessage(SoapMessage message) throws Fault {  
    	 WrappedMessageContext ctx = new WrappedMessageContext(message.getExchange().getInMessage(), Scope.APPLICATION);  
    	 HttpServletRequest request = (HttpServletRequest)ctx.get(WrappedMessageContext.SERVLET_REQUEST);
    	 List<Header> headers = message.getHeaders();  
         if (null == headers || headers.size() < 1) {  
             throw new Fault(new SOAPException("报文信息有误，请联系系统管理员！CODE：4050"));  
         }
         String userName = null;
         String password = null;
         for (Header header : headers) {  
        	 SoapHeader soapHeader = (SoapHeader) header;  
        	 // 取出SOAP的Header元素  
        	 Element element = (Element) soapHeader.getObject();
        	 if("linkwsh:UsernameToken".equals(element.getNodeName())){
        		 userName = element.getTextContent();
        	 }
        	 if("linkwsh:PasswordText".equals(element.getNodeName())){
        		 password = element.getTextContent();
        	 }
         }
         

    	 if(userName == null || "".equals(userName)){
    		 SOAPException soapExc = new SOAPException("报文信息有误，请联系系统管理员！CODE：4051");  
			 throw new Fault(soapExc);
    	 }
    	 if(password == null || "".equals(password)){
    		 SOAPException soapExc = new SOAPException("报文信息有误，请联系系统管理员！CODE：4052");  
			 throw new Fault(soapExc);
    	 }

    	 //根据用户名username加载userDetails  
    	 User user = (User)loginService.loadUserByUsername(userName);  
    	 
    	 if(userPasswordEncoder.webserviceValid(user.getPassword(), password, user.getCorpid(),user.getUsername())){
    		 SOAPException soapExc = new SOAPException("用户名或密码错误，请联系系统管理员！CODE：4053"); 
    		 throw new Fault(soapExc);
    	 }
    	 
    	 //根据userDetails构建新的Authentication,这里使用了  
    	 //PreAuthenticatedAuthenticationToken当然可以用其他token,如UsernamePasswordAuthenticationToken                 
    	 PreAuthenticatedAuthenticationToken authentication =   
    			 new PreAuthenticatedAuthenticationToken(user, user.getPassword(),user.getAuthorities());  

    	 //设置authentication中details  
    	 authentication.setDetails(new WebAuthenticationDetails(request));  

    	 //存放authentication到SecurityContextHolder  
    	 SecurityContextHolder.getContext().setAuthentication(authentication);  
    	 HttpSession session = request.getSession(true);  
    	 //在session中存放security context,方便同一个session中控制用户的其他操作  
    	 session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());  

     }  */
}  

