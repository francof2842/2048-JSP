<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Red Hat </title>
</head>
<body>
<%out.println("Running Red Hat Game: ");%>
<%@ page import="Juego.ConsoleGame" %> 
<%@ page import="Juego.game.Board" %> 
<%@ page import="Juego.ai.AiSolver" %> 
<%@ page import="Juego.dataobjects.Direction" %> 
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="java.io.*,java.util.*" %>


<%! public static boolean play=true;

%>

<%
	final JspWriter finalOut = out;
   // Set refresh, autoload time as 5 seconds
   response.setIntHeader("Refresh", 5);
	Thread thread = new Thread(new Runnable() {
    @Override
    public void run() {
        while (play == true) {

	        try {
	            ejecutar(finalOut);
	        } catch (CloneNotSupportedException ex) {
	        	
	        } catch(Exception e) {
	        	
	        }
        }
    }
});
thread.start();
%>

<%! private void ejecutar(javax.servlet.jsp.JspWriter out) throws CloneNotSupportedException, IOException, JSONException{

 	ConsoleGame cGame = new ConsoleGame();
 	out.println("Running Red Hat Game: ");
 	out.println("NOW: ");
	
 	JSONObject json = new JSONObject();
 	json = cGame.readJsonFromUrl("http://nodejs2048-universidades.rhcloud.com/hi/start/MTG/json");
 	Board game = new Board(json.get("grid").toString());
 	game.setSession(json.get("session_id").toString());
 	System.out.println("Session: " + game.getSession());
 	cGame.setBoardStatus(game, json);
	
 	Direction hint = AiSolver.findBestMove(game);

 	cGame.movementJson(game, hint);
	
 	cGame.setBoardStatus(game, json);
	
 	cGame.printFullBoard(game, json, hint);
	
 	while (game.getWon() == false && game.getOver() == false){
 	    hint = AiSolver.findBestMove(game);
 	    cGame.movementJson(game, hint);
 	   out.println("=====================================");
	    
	}
 	play = false;
 	out.println("<BR>");
 	out.println("=====================================");
 	out.println("<BR>");
 	out.println("Finish Red Hat! ");
 	out.println("<BR>");
 	out.println("=====================================");
 	out.println("<BR>");
 	out.println("Won: " + game.getWon() );
 	out.println("<BR>");
 	out.println("Over: " + game.getOver());
 	out.println("<BR>");
 	out.println("Score: " + game.getScore());
 	out.println("<BR>");
 	out.println("Total Number of Movements: " + game.getMoves());
 	out.println("<BR>");
 	out.println("Session Id: " + game.getSession());
}
%>




</body>
</html>