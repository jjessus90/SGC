



<div class="fieldcontain ${hasErrors(bean: localidadInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="localidad.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${localidadInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: localidadInstance, field: 'documentos', 'error')} ">
	<label for="documentos">
		<g:message code="localidad.documentos.label" default="Documentos" />
		
	</label>
	<g:select name="documentos" from="${Documento.list()}" multiple="multiple" optionKey="id" size="5" value="${localidadInstance?.documentos*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: localidadInstance, field: 'estado', 'error')} required">
	<label for="estado">
		<g:message code="localidad.estado.label" default="Estado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="estado" name="estado.id" from="${Estado.list()}" optionKey="id" required="" value="${localidadInstance?.estado?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: localidadInstance, field: 'municipio', 'error')} required">
	<label for="municipio">
		<g:message code="localidad.municipio.label" default="Municipio" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="municipio" name="municipio.id" from="${Municipio.list()}" optionKey="id" required="" value="${localidadInstance?.municipio?.id}" class="many-to-one"/>
</div>

