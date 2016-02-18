

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuarioSistema.label', default: 'UsuarioSistema')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- INICIA --ADMINISTRADOR -->
  <sec:ifAllGranted roles="ROLE_ADMINISTRADOR">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'usuarioSistema.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'usuarioSistema.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="nombreCompleto" title="${message(code: 'usuarioSistema.nombreCompleto.label', default: 'Nombre Completo')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'usuarioSistema.enabled.label', default: 'Activo')}" />
                                                                              
                            <g:sortableColumn property="email" title="${message(code: 'usuarioSistema.email.label', default: 'Email')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${usuarioSistemaInstanceList}" status="i" var="usuarioSistemaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${usuarioSistemaInstance.id}">${fieldValue(bean: usuarioSistemaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: usuarioSistemaInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: usuarioSistemaInstance, field: "nombreCompleto")}</td>
                            
                            <td>
                                
                                <g:if test="${usuarioSistemaInstance.enabled}">
                                    <img src="${resource(dir:'images/skin',file:'arrow.png')}" height="20px" width="20px" />
                                    
                                    </g:if>
                                    <g:else>
                                       <img src="${resource(dir:'images/skin',file:'false.png')}" height="20px" width="20px" /> 
                                    </g:else>
                                
                                
                                </td>
                        
                            <td>${fieldValue(bean: usuarioSistemaInstance, field: "email")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
      <g:paginate total="${total}" />
    </div>
            
        </div>
        </sec:ifAllGranted>
  <!--  TERMINA ----- ADMINISTRADOR -->
    
    <sec:ifNotGranted roles="ROLE_ADMINISTRADOR">
		No estas autorizado...
	</sec:ifNotGranted>
    </body>
</html>
