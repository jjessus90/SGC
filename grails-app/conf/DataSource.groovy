dataSource {
    configClass=GrailsAnnotationConfiguration.class
    pooled = false
    driverClassName = "com.mysql.jdbc.Driver"
    dialect="org.hibernate.dialect.MySQL5InnoDBDialect"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}


// environment specific settings
environments {
    
    development {
        dataSource {
            username = "root"
            password = "admin"               
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/db_ss" //servidor pruebas
            //url = "jdbc:mysql://localhost:3306/db_ss-seg-dos" //servidor local
           
        }
    }
    test {
        dataSource {
            username = "root"
            password = "admin"               
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/db_ss" //servidor pruebas
            //url = "jdbc:mysql://localhost:3306/db_ss-seg-dos" //servidor local
        }
    }
    production {
        dataSource {
            username = "root"
            password = "admin"               
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/db_ss" //servidor pruebas
            //url = "jdbc:mysql://localhost:3306/db_ss-seg-dos" //servidor local
        }
    }
    
}
