



<div class="fieldcontain ${hasErrors(bean: municipioInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="municipio.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${municipioInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: municipioInstance, field: 'dependencias', 'error')} ">
	<label for="dependencias">
		<g:message code="municipio.dependencias.label" default="Dependencias" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${municipioInstance?.dependencias?}" var="d">
    <li><g:link controller="dependencia" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="dependencia" action="create" params="['municipio.id': municipioInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'dependencia.label', default: 'Dependencia')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: municipioInstance, field: 'documentos', 'error')} ">
	<label for="documentos">
		<g:message code="municipio.documentos.label" default="Documentos" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${municipioInstance?.documentos?}" var="d">
    <li><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="documento" action="create" params="['municipio.id': municipioInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'documento.label', default: 'Documento')])}</g:link>
</li>
</ul>

</div>

