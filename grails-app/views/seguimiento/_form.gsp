


<div style="display: none">
<div class="fieldcontain ${hasErrors(bean: seguimientoInstance, field: 'documento', 'error')} required">
	<label for="documento">
		<g:message code="seguimiento.documento.label" default="Documento" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="documento" name="documento.id" from="${Documento.list()}" optionKey="id" required="" value="${seguimientoInstance?.documento?.id}" class="many-to-one"/>

</div></div>

<div class="fieldcontain ${hasErrors(bean: seguimientoInstance, field: 'seguimiento', 'error')} ">
	<label for="seguimiento">
		<g:message code="seguimiento.seguimiento.label" default="Seguimiento" />
		
	</label>
	<g:textArea name="seguimiento" value="${seguimientoInstance?.seguimiento}"/>
</div>

