

class ReporteController {

    def index() { }

    def reporteSobrePDF(){//////////////reporteController de   CORRESPONDENCIA
        
        def documentoInstance = new Documento(params)
        def realPath = servletContext.getRealPath("images/")
        params.realPath=realPath
                
        def ListadocumentoInstance = Documento.findAll("FROM Documento d where d.id=${params.idDocumento as int}")
        
        def depRemitente = ListadocumentoInstance.dependenciaRemitente.id
        def remit = ListadocumentoInstance.persona.id
        
        
        if(remit){
            if(ListadocumentoInstance){
                def resultadoFormateado = ListadocumentoInstance.collect {
                    [
                        idDocumento:it.id,
                        remitente:it.persona.nombre,
                        direccion: it.persona.calleNumero+" Col. "+it.persona.colonia,
                        municipio: it.persona.municipio.nombre
                
                    ]
                }
                //infinitatrend
                //ftucomunidad
                
                chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
            }else{
//                println"No entramos al reporte porque no hay instancias"
            }//fin else
        }//fin Remitente
        else if(depRemitente){
            
            
            if(ListadocumentoInstance){
                def resultadoFormateado = ListadocumentoInstance.collect {
                    [
                        idDocumento:it.id,
                        remitente:it.dependenciaRemitente.nombre,
                        direccion: it.dependenciaRemitente.calleNumero+" Col. "+it.dependenciaRemitente.colonia,
                        municipio: it.dependenciaRemitente.municipio.nombre
                
                    ]
                }
                //infinitatrend
                //ftucomunidad
                
                chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
            }else{
//                println"No entramos al reporte porque no hay instancias"
            }//fin else
            
        }
        
    
    }
    
    def obtenerCargoFuncionario(idDependencia){
        
        def funcionarioInstance = Persona.executeQuery("select f.cargo FROM Funcionario f where f.dependencia=${idDependencia as int}")                
        def nombre = funcionarioInstance[0] as String
                              
        return nombre
    }
    
    def obtieneTurnadoResponsable(idDocumento){
        
        def responsableInstance
        
        
    }
    def volanteOrdinarioPDF(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
        println "realpath es: " + realPath;
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        
        if(params.dependenciaRemitente){
            //println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        params.fechaCaptura=(documentoInstance.fechaRecibido).format("dd-MMM-yyyy")
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int}")
        
//        println"los turnados son"+turnadoInstance.persona.nombre
        if(turnadoInstance){
            def resultadoFormateado = turnadoInstance.collect {
                [
                    dependencia:it.dependencia.nombre,
                    persona:it.persona.nombre,
                    responsabilidad: it.responsabilidad,
                    remitente:remit
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }
            
    }
    
    def volanteMunicipal(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
//        println "realpath es: " + realPath;
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        
        if(params.dependenciaRemitente){
            //println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        def dia=(documentoInstance.fechaRecibido).format("dd")
        def numMes=(documentoInstance.fechaRecibido).format("MM")
       
        def mes = null
        if(numMes=='01') mes ="enero"
        if(numMes=='02') mes ="febrero"
        if(numMes=='03') mes ="marzo"
        if(numMes=='04') mes ="abril"
        if(numMes=='05') mes ="mayo"
        if(numMes=='06') mes ="junio"
        if(numMes=='07') mes ="julio"
        if(numMes=='08') mes ="agosto"
        if(numMes=='09') mes ="septiembre"
        if(numMes=='10') mes ="octubre"
        if(numMes=='11') mes ="noviembre"
        if(numMes=='12') mes ="diciembre"
        def anio=(documentoInstance.fechaRecibido).format("yyyy")
        String fecha = "Cuernavaca, Mor., a " +dia+ " de " +mes+ " de "+anio
        params.fechaCaptura = fecha
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int}")
        int contadorCCP = 0
        int contadorResponsable = 0
        ArrayList indiceResp = new ArrayList();
        ArrayList indiceCCP = new ArrayList();
                
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="RESPONSABLE"){
                contadorResponsable ++
                indiceResp.add(i)
        
            }
        }
        if(contadorResponsable==1){
            params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
        }
        if(contadorResponsable==2){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
        }
        if(contadorResponsable==3){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(2)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(2)].toLowerCase())
        }
        if(contadorResponsable==4){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(2)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(2)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(3)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(3)].toLowerCase())
        }
       
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="CCP"){
                contadorCCP ++
                indiceCCP.add(i)
//                println "nombre: " +turnadoInstance.persona.nombre[i]              
            }
        }
       
        if(contadorCCP==1){
            params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==2){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==3){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==4){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"               
             params.ccpCuatro = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(3)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(3)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(3)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        params.municipioRemitente = documentoInstance.persona.municipio
        params.estadoRemitente = documentoInstance.persona.estado
        def lugar
        if(params.municipioRemitente==null || params.municipioRemitente==""){
            lugar = documentoInstance.persona.estado
                      
        }
        else{
            lugar = params.municipioRemitente.toString() + ", "+params.estadoRemitente  
        }
        params.municipioRemitente = lugar.toString()
        params.cargoPersona = toTitleCase(turnadoInstance.persona.cargo[0].toLowerCase())
        params.cargoRemitente = toTitleCase(documentoInstance.persona.cargo.toLowerCase())
        params.municipio = documentoInstance.persona.municipio.toString()
        params.dependenciaRemitente = toTitleCase(documentoInstance.persona.dependencia.toString().toLowerCase())
        if(turnadoInstance.persona.cargo){
            def resultadoFormateado = turnadoInstance.collect {
                [
                    dependencia:it.dependencia.nombre,
                    persona:toTitleCase(it.persona.nombre.toLowerCase()),
                    responsabilidad: it.responsabilidad,
                    remitente:toTitleCase(remit.toLowerCase())
                    
                ]
            }


        if(params.cargoRemitente==null || params.cargoRemitente==""){
            params.dataPerson = params.dependenciaRemitente
        }
        else{
            params.dataPerson = params.cargoRemitente+", "+params.dependenciaRemitente
        }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }
            
    }
    
    def volanteOrdinario(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
       //println "realpath es: " + realPath;
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        
        if(params.dependenciaRemitente){
            //println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
        
        def documentoInstance = Documento.get(params.idDocumento as int)
        def dia=(documentoInstance.fechaRecibido).format("dd")
        def numMes=(documentoInstance.fechaRecibido).format("MM")
       
        def mes = null
        if(numMes=='01') mes ="enero"
        if(numMes=='02') mes ="febrero"
        if(numMes=='03') mes ="marzo"
        if(numMes=='04') mes ="abril"
        if(numMes=='05') mes ="mayo"
        if(numMes=='06') mes ="junio"
        if(numMes=='07') mes ="julio"
        if(numMes=='08') mes ="agosto"
        if(numMes=='09') mes ="septiembre"
        if(numMes=='10') mes ="octubre"
        if(numMes=='11') mes ="noviembre"
        if(numMes=='12') mes ="diciembre"
        def anio=(documentoInstance.fechaRecibido).format("yyyy")
        String fecha = "Cuernavaca, Mor., a " +dia+ " de " +mes+ " de "+anio
        params.fechaCaptura = fecha
        int contadorCCP = 0
        int contadorResponsable = 0
        ArrayList indiceResp = new ArrayList();
        ArrayList indiceCCP = new ArrayList();
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int}")
              
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="RESPONSABLE"){
                contadorResponsable ++
                indiceResp.add(i)
        
            }
        }
        if(contadorResponsable==1){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo = toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
        }
        if(contadorResponsable==2){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
        }
        if(contadorResponsable==3){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(2)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(2)].toLowerCase())
        }
        if(contadorResponsable==4){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(2)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(2)].toLowerCase())
             params.nombreCuatro = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(3)].toLowerCase())
             params.cargoCuatro =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(3)].toLowerCase())
        }
		if(contadorResponsable==5){
             params.nombre = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(0)].toLowerCase())
             params.cargo =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(0)].toLowerCase())
             params.nombreDos = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(1)].toLowerCase())
             params.cargoDos =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(1)].toLowerCase())
             params.nombreTres = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(2)].toLowerCase())
             params.cargoTres =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(2)].toLowerCase())
             params.nombreCuatro = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(3)].toLowerCase())
             params.cargoCuatro =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(3)].toLowerCase())
			 params.nombreCinco = toTitleCase(turnadoInstance.persona.nombre[indiceResp.get(4)].toLowerCase())
             params.cargoCinco =  toTitleCase(turnadoInstance.persona.cargo[indiceResp.get(4)].toLowerCase())
        }
       
        
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="CCP"){
                contadorCCP ++
                indiceCCP.add(i)
                  
            }
        }
        
        if(contadorCCP==1){
            params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==2){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==3){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==4){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"               
             params.ccpCuatro = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(3)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(3)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(3)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==5){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"               
             params.ccpCuatro = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(3)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(3)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(3)].toString().toLowerCase())+".-Para su conocimiento"    
             params.ccpCinco = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(4)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(4)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(4)].toString().toLowerCase())+".-Para su conocimiento"    

        }
        params.municipioRemitente = documentoInstance.persona.municipio
        params.estadoRemitente = documentoInstance.persona.estado
        def lugar
        if(params.municipioRemitente==null || params.municipioRemitente==""){
            lugar = documentoInstance.persona.estado
                      
        }
        else{
            lugar = params.municipioRemitente.toString() + ", "+params.estadoRemitente  
        }

        params.municipioRemitente = lugar.toString()
        
        if(documentoInstance.signatario.equals('Lic. Paola Gadsden de la Peza')){
            params.signatario = documentoInstance.signatario
            params.cargoSignatario = 'Jefa de la Oficina de la Gubernatura del Estado'
            params.presente = "Con fundamento en los artículos 1, 2, 3, 4, 9 y 10 fracción VIII del reglamento interior de la 'Oficina de la Gubernatura del Estado' publicado en el periódico oficial Tierra y Libertad número 5353 con fecha 18 de Diciembre de 2015; 11 y 13 de la ley Orgánica de la Administración Pública del Estado de Morelos, le remito el siguiente asunto:"    
        }
        else if(documentoInstance.signatario.equals('Mariana Ugalde Morán')){
            params.signatario=documentoInstance.signatario
            params.cargoSignatario = 'Secretaria Técnica de la Oficina de la Gubernatura del Estado'
            params.presente = "Con fundamento en los artículos 1, 2, 4 fracción X, 6, fracción II, y 20 del reglamento interior de la 'Oficina de la Gubernatura del Estado' publicado en el periódico oficial Tierra y Libertad número 5353 con fecha 18 de Diciembre de 2015, le remito el siguiente asunto: "
        }
        
        if(documentoInstance.persona!=null){
            if(documentoInstance.persona.municipio!=null){lugar = documentoInstance.persona.municipio}
            else{lugar = documentoInstance.persona.estado}   
        
            params.cargoRemitente = toTitleCase(documentoInstance.persona.cargo.toLowerCase())
            params.dependenciaRemitente = toTitleCase(documentoInstance.persona.dependencia.toString().toLowerCase())
            params.cargoPersona = toTitleCase(turnadoInstance.persona.cargo[0].toLowerCase())
        }
        else{
            
            if(documentoInstance.dependenciaRemitente.municipio!=null){
                lugar = documentoInstance.dependenciaRemitente.municipio}
            else{lugar = documentoInstance.dependenciaRemitente.estado}    
           
        }        
        
        if(params.cargoRemitente==null || params.cargoRemitente==""){
            params.dataPerson = params.dependenciaRemitente
        }
        else{
            params.dataPerson = params.cargoRemitente+", "+params.dependenciaRemitente
        }
        
//        
//        if(params.municipioRemitente!=null){
//            lugar = params.municipioRemitente.toString()
//            println "lugar: "+lugar
//            lugar = lugar +", "+params.estadoRemitente  
//        }
//        else{
//            lugar = documentoInstance.persona.estado
//        }
        //params.municipioRemitente = toTitleCase(lugar.toString().toLowerCase())
        
        
        if(turnadoInstance.persona.cargo){
            def resultadoFormateado = turnadoInstance.collect {
                [
                    dependencia:toTitleCase(it.dependencia.nombre.toLowerCase()),
                    persona:it.persona.nombre,
                    responsabilidad: it.responsabilidad,
                    remitente:toTitleCase(remit.toLowerCase())
                    
                ]
            }

            //println("Asunto:"+documentoInstance.asunto)
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }
            
    }
    
    def memoPDF(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
        
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        
        if(params.dependenciaRemitente){
//            println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        params.fechaCaptura=(documentoInstance.fechaRecibido).format("dd-MMM-yyyy")
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int}")
        
        if(turnadoInstance){
            def resultadoFormateado = turnadoInstance.collect {
                [
                    dependencia:it.dependencia.nombre,
                    persona:it.persona.nombre,
                    responsabilidad: it.responsabilidad,
                    remitente:remit
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }
            
    }
    

    def cartaRespuestaPDF(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
        
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        ///////////////////aqui determinamos si la dependencia es un remitente o si es una persona
        if(params.dependenciaRemitente){
//            println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        params.fechaCaptura=(documentoInstance.fechaRecibido).format("dd-MMM-yyyy")
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int} and t.responsabilidad like'%RESPONSABLE%'")
        
        
        def documentInstance=Documento.executeQuery("Select d.persona FROM Documento d where d.id=${params.idDocumento as int}")
        def remitentePersona=documentInstance[0]
        
        
        
        if(remitentePersona){
        
        if(turnadoInstance){//mandamos parametros al reporte si el remitente es una persona
            def resultadoFormateado = turnadoInstance.collect {
                [
                    funcionario:it.persona.nombre,
                    remitente:remit,
                    cargoFuncionario:it.persona.cargo,
                    direccion: it.persona.calleNumero+" Col. "+it.persona.colonia,
                    fechaTurnado: it.documento.fechaCaptura,
                    folio: it.documento.folio,
                    municipio: it.persona.municipio.nombre,
                    presente: it.documento.presente
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }//fin turnado if
        
        }else{
            
            if(turnadoInstance){//mandamos parametros al reporte si el remitente es una persona
            def resultadoFormateado = turnadoInstance.collect {
                [
                    funcionario:it.persona.nombre,
                    remitente:remit,
                    cargoFuncionario:it.persona.cargo,
                    direccion: it.documento.dependenciaRemitente.calleNumero+" Col. "+it.documento.dependenciaRemitente.colonia,
                    fechaTurnado: it.documento.fechaCaptura,
                    folio: it.documento.folio,
                    municipio: it.documento.dependenciaRemitente.municipio.nombre,
                    presente: it.documento.presente
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }//fin turnado if
            
            
        }
        
            
    }
    
    def cartaDeNoApoyoPDF(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
        
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        ///////////////////aqui determinamos si la dependencia es un remitente o si es una persona
        if(params.dependenciaRemitente){
//            println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        params.fechaCaptura=(documentoInstance.fechaRecibido).format("dd-MMM-yyyy")
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int} and t.responsabilidad like'%RESPONSABLE%'")
        
        
        def documentInstance=Documento.executeQuery("Select d.persona FROM Documento d where d.id=${params.idDocumento as int}")
        def remitentePersona=documentInstance[0]
        
        
        
        if(remitentePersona){
        
        if(turnadoInstance){//mandamos parametros al reporte si el remitente es una persona
            def resultadoFormateado = turnadoInstance.collect {
                [
                    remitente:remit,
                    fechaTurnado: it.documento.fechaCaptura,
                    folio: it.documento.folio,
                    municipio: it.persona.municipio.nombre,
                    presente: it.documento.presente
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }//fin turnado if
        
        }else{
            
            if(turnadoInstance){//mandamos parametros al reporte si el remitente es una persona
            def resultadoFormateado = turnadoInstance.collect {
                [
                    remitente:remit,
                    fechaTurnado: it.documento.fechaCaptura,
                    folio: it.documento.folio,
                    municipio: it.documento.dependenciaRemitente.municipio.nombre,
                    presente: it.documento.presente
                    
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }//fin turnado if
            
            
        }
        
            
    }
    
    def obtieneFuncionario(IdDocumento){
        
        def turnadoInstance = Turnado.executeQuery("select t.persona.nombre FROM Turnado t where t.documento=${IdDocumento as int} and t.responsabilidad like'%RESPONSABLE%'")                
        def nombre = turnadoInstance[0] as String
                              
        return nombre
    }

    def obtieneCargoFuncionario(idDocumento){
        def turnadoInstance = Turnado.executeQuery("select t.persona.cargo FROM Turnado t where t.documento=${IdDocumento as int} and t.responsabilidad like'%RESPONSABLE%'")                
        def cargo = turnadoInstance[0] as String
                              
        return cargo
        
    }
    //REPORTE DE GIRAS
    def girasPDF(){
        
        int contadorCCP = 0
        int contadorResponsable = 0
        ArrayList indiceResp = new ArrayList();
        ArrayList indiceCCP = new ArrayList();
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath
//        println "realpath es: " + realPath;
//        println"remitenteDep es: "+params.dependenciaRemitente
        
        def remit
        
        if(params.dependenciaRemitente){
//            println"aqui en dependencia"
            remit=params.dependenciaRemitente
        }else if(params.remitente && !params.dependenciaRemitente){
//            println"remitente entonces es=."+params.remitente
//            println"porque entramos aqui..."
            remit=params.remitente
        }
       
        
        def estado = params.estado;
//        println "el lugar es: "+lugar
//        println "el esrado es: "+estado
//        println"el remitente es: "+remit
        def documentoInstance = Documento.get(params.idDocumento as int)
        params.fechaCaptura=(documentoInstance.fechaRecibido).format("dd-MMM-yyyy")
        def personaInstance = Persona.get(params.person)
        //Obtener el municipio del remitente//**********
        
        params.municipioRemitente = documentoInstance.persona.municipio
        def lugar = params.municipioRemitente.toString()
        params.municipioRemitente = lugar +", Morelos."
        
      
        params.municipioRemitente = lugar.toString().toUpperCase()
        params.cargoRemitente = documentoInstance.persona.cargo.toUpperCase()
        params.dependenciaRemitente = documentoInstance.persona.dependencia.toString().toUpperCase()
       
        
        
        
        def turnadoInstance = Turnado.findAll("From Turnado t where t.documento=${params.idDocumento as int}")
        //println "cargo de persona"+personaInstance.cargo
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="RESPONSABLE"){
                contadorResponsable ++
                indiceResp.add(i)
        
            }
        }
        if(contadorResponsable==1){
             params.nombre = turnadoInstance.persona.nombre[indiceResp.get(0)].toUpperCase()
             params.cargo = turnadoInstance.persona.cargo[indiceResp.get(0)].toUpperCase()
        }
        if(contadorResponsable==2){
             params.nombre = turnadoInstance.persona.nombre[indiceResp.get(0)].toUpperCase()
             params.cargo =  turnadoInstance.persona.cargo[indiceResp.get(0)].toUpperCase()
             params.nombreDos = turnadoInstance.persona.nombre[indiceResp.get(1)].toUpperCase()
             params.cargoDos =  turnadoInstance.persona.cargo[indiceResp.get(1)].toUpperCase()
        }
         if(contadorResponsable==3){
             params.nombre = turnadoInstance.persona.nombre[indiceResp.get(0)].toUpperCase()
             params.cargo =  turnadoInstance.persona.cargo[indiceResp.get(0)].toUpperCase()
             params.nombreDos = turnadoInstance.persona.nombre[indiceResp.get(1)].toUpperCase()
             params.cargoDos =  turnadoInstance.persona.cargo[indiceResp.get(1)].toUpperCase()
             params.nombreTres = turnadoInstance.persona.nombre[indiceResp.get(2)].toUpperCase()
             params.cargoTres =  turnadoInstance.persona.cargo[indiceResp.get(2)].toUpperCase()
        }
        for(int i=0; i<=turnadoInstance.size();i++){
            if(turnadoInstance.responsabilidad[i]=="CCP"){
                contadorCCP ++
                indiceCCP.add(i)
                  
            }
        }
       
        if(contadorCCP==1){
            params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==2){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==3){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"    
        }
        if(contadorCCP==4){
             params.ccp = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(0)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(0)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(0)].toString().toLowerCase())+".-Para su conocimiento"       
             params.ccpDos = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(1)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(1)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(1)].toString().toLowerCase())+".-Para su conocimiento"     
             params.ccpTres = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(2)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(2)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(2)].toString().toLowerCase())+".-Para su conocimiento"               
             params.ccpCuatro = "C.c.p " +toTitleCase(turnadoInstance.persona.nombre[indiceCCP.get(3)].toLowerCase())+".-"+toTitleCase(turnadoInstance.persona.cargo[indiceCCP.get(3)].toLowerCase())+" - "+toTitleCase(turnadoInstance.persona.dependencia[indiceCCP.get(3)].toString().toLowerCase())+".-Para su conocimiento"    
        }
//        println "persona cargo "+turnadoInstance.persona.cargo[1]
//        println"los turnados son"+turnadoInstance.persona.nombre
        
        if(turnadoInstance){
            def resultadoFormateado = turnadoInstance.collect {
                [
                    dependencia:it.dependencia.nombre,
                    persona:it.persona.nombre,
                    responsabilidad: it.responsabilidad,
                    cargo:it.persona.cargo,
                    remitente:remit                                        
                ]
            }
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params, lugar:lugar)
        }
        
            
    }
    ///***Método para convertir el texto a versales***///
   

     def tarjetaInformativa(){
        
        def realPath = servletContext.getRealPath("images/reports")
        params.realPath=realPath     
            
        
        
        def tarjetaInformativaInstance = TarjetaInformativa.get(params.idTarjeta as int)
        def dia=(tarjetaInformativaInstance.fechaCaptura).format("dd")
        def numMes=(tarjetaInformativaInstance.fechaCaptura).format("MM")
        def cargoRemit = toTitleCase(tarjetaInformativaInstance.remitente.cargo.toString().toLowerCase())
        params.cargoRemitente = cargoRemit
        params.remitente = toTitleCase(tarjetaInformativaInstance.remitente.nombre.toString().toLowerCase())
        
        def mes = null
        if(numMes=='01') mes ="enero"
        if(numMes=='02') mes ="febrero"
        if(numMes=='03') mes ="marzo"
        if(numMes=='04') mes ="abril"
        if(numMes=='05') mes ="mayo"
        if(numMes=='06') mes ="junio"
        if(numMes=='07') mes ="julio"
        if(numMes=='08') mes ="agosto"
        if(numMes=='09') mes ="septiembre"
        if(numMes=='10') mes ="octubre"
        if(numMes=='11') mes ="noviembre"
        if(numMes=='12') mes ="diciembre"
        def anio=(tarjetaInformativaInstance.fechaCaptura).format("yyyy")
        String fecha = "Cuernavaca, Mor., a " +dia+ " de " +mes+ " de "+anio
        params.fechaCaptura = fecha
        
        
        ArrayList indiceResp = new ArrayList();
        def turnadoTarjetaInstance = TurnadoTarjeta.findAll("From TurnadoTarjeta t where t.tarjetaInformativa=${params.idTarjeta as int}")

        params.nombre = toTitleCase(turnadoTarjetaInstance.persona.nombre[0].toLowerCase())
        params.cargo = toTitleCase(turnadoTarjetaInstance.persona.cargo[0].toLowerCase())
        /*      
        int contadorResponsable = turnadoTarjetaInstance.size()
        if(contadorResponsable==1){
             params.nombre = toTitleCase(turnadoTarjetaInstance.persona.nombre.toString().toLowerCase())
             params.cargo = toTitleCase(turnadoTarjetaInstance.persona.cargo.toString().toLowerCase())
        }
        def per = toTitleCase(turnadoTarjetaInstance.persona.nombre.toString().toLowerCase())
        println "nombre: " + per*/
        
        if(turnadoTarjetaInstance.persona.cargo){
            def resultadoFormateado = turnadoTarjetaInstance.collect {
                [
                    //dependencia:toTitleCase(it.dependencia.nombre.toLowerCase()),
                    persona:it.persona.nombre
                  
                    
                ]
            }

            //println("Asunto:"+documentoInstance.asunto)
        
            chain(controller: "jasper", action: "index", model: [data: resultadoFormateado], params:params)
        }
            
    } 

     public static String toTitleCase(String input) {
        StringBuilder titleCase = new StringBuilder();
        boolean nextTitleCase = true;

        for (char c : input.toCharArray()) {
            if (Character.isSpaceChar(c)) {
                nextTitleCase = true;
            } else if (nextTitleCase) {
                //println c
                c = Character.toTitleCase(c);
                nextTitleCase = false;
            }

            titleCase.append(c);
        }
        String delimitadores= "[ ,;?!¡¿\'\"\\[\\]]+";
        String[] conectores = titleCase.toString().split(delimitadores)
        String newCad=""
       
        newCad = conectores.toString().replace(',','')
        //println titleCase
    //    println titleCase.toString()
        newCad = newCad.replace(" De "," de ")
        newCad = newCad.replace(" Del "," del ")
        newCad = newCad.replace(" Para "," para ")
        newCad = newCad.replace(" Y "," y ")
        newCad = newCad.replace("[","")
        newCad = newCad.replace("]","")
        newCad = newCad.replace("La","la")

        //println "---------------------"+newCad.toString();
        return newCad.toString();
    }
    
}
