<html>
  <head>
    <title>Sistema de Correspondencia</title>
    <meta name="layout" content="login" />   
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=PT+Sans:400,700" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'supersized.css')}" type="text/css">
  </head>
  <body>
    <div class="page-container">      
            <g:if test='${flash.message}'>
                <div class='login_message'>${flash.message}</div>
            </g:if>
                    <form action='${postUrl}' method='POST' autocomplete='off'>            
                        <h1>Sistema de Gestión de Correspondencia</h1>
                        <br/>
                        <h3>Login</h3>                
                        <div>
                            <input type="text" placeholder="Username" name="j_username" required="" id="username" class="username" placeholder="Username"/>
                        </div>
                        <div>
                            <input type="password" name="j_password" placeholder="Password" required="" id="password" class="password" placeholder="Password"/>
                        </div>
                        <div>
                            <button type="submit" value="Entrar">Entrar</button>
                        </div>
                    </form><!-- form -->
    </div>
    <br/><br/><a href="http://www.morelos.gob.mx"><img src="../images/assets/Escudo.png"  height="302" width="402"></img></a>
    <g:javascript src="jquery-1.8.2.min.js"/>    
    <g:javascript src="supersized.3.2.7.min.js"/>
    <g:javascript src="supersized-init.js"/>
    <g:javascript src="scripts.js"/>
  </body>
</html>
