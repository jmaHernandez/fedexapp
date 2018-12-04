# README

Este proyecto fue realizado con rails 5.2.1 y angular 5 embebido esto con el fin de poder subirlo a la plataforma de heroku usando solamente un dyno para evitar costos al cargarlo a producción.

EL proyecto consiste en conectarse a la APi de Fedex para obtener información sobre los paquetes enviados y realizar los calculos para obtener el pero en kilogramos, el peso volumetrico y el sobreso, tambien muestra un reporte de los packetes que han sido almacenados en la base de datos, en este caso usando postgres.

Github:

* https://github.com/jmaHernandez/fedexapp.git

Heroku:

* https://fedexapp.herokuapp.com

# Ambiente local

Para ejecutar este proyecto de manera local es necesario descargar el repositorio de github, colocarse dentro del directorio del proyecto y ejecutar el comando `bundle install`, una vez que sea han terminado de instalar las dependencias tendremos que ejecutar el comando `rails s`, una vez que la aplicación ha sido ejecutada, nos dirigimos a la siguiente url:

* http://localhost:4000/home

## Archivo de ejemplo

Para un ejemplo se puede usar el archivo **fedex_packages_example.json** para cargar la información en la app.

## Nota

Una vez que se ha descargado el proyecto y se han instalado las dependencias es muy probable que se tenga que crear la base de datos, para este paso en necesario ejecutar el siguiente comando:

`$ rake db:migrate`
