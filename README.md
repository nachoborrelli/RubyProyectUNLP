* Ruby version  
  Ruby 2.7.0

* System dependencies  
  Ejecutar ```bundle install```


* Database creation
  Se utiliza el motor mysql.   
  Ejecutar el comando ```rails db:create```
  
* Database initialization   
  Ejecutar ```rails db:migrate```

* How to run the test suite   
  Ejecutar ```rails db:seed```. Este creara un usuario "prueba@hotmail.com" con contraseña "123456" con cuadernos y 
  notas pre-hechas con motivos de prueba.   
    Ejecutar ```rails s``` para iniciar el servidor, y acceder a 127.0.0.1:3000




***Decisiones de diseño***

- Para el modelo de datos se utilizaron Scaffolds, lo que permitió generar vistas, controladores y modelos de datos pre-definidos

- Para la exportación de notas se utilizó la librería "Kramdown". Esta transforma el texto plano en texto rico según
    una seria de comandos predefinidos. Toda nota será exportada en formato HTML.
    
- La descarga de las notas se realiza mediante el navegador, dejando al usuario elegir el path final de descarga

- La exportacion de mas de una nota se realiza mediante un zip.

- Para el registro e inicio de sesión se utilizo la gema "Devise"

