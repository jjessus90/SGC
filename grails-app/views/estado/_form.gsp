



<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="estado.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${estadoInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'dependencias', 'error')} ">
	<label for="dependencias">
		<g:message code="estado.dependencias.label" default="Dependencias" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${estadoInstance?.dependencias?}" var="d">
    <li><g:link controller="dependencia" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="dependencia" action="create" params="['estado.id': estadoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'dependencia.label', default: 'Dependencia')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'documentos', 'error')} ">
	<label for="documentos">
		<g:message code="estado.documentos.label" default="Documentos" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${estadoInstance?.documentos?}" var="d">
    <li><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="documento" action="create" params="['estado.id': estadoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'documento.label', default: 'Documento')])}</g:link>
</li>
</ul>

</div>

