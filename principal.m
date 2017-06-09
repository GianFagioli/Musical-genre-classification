%Clasificador de géneros musicales (Script general)
%1) Entrenamiento: Para cada canción cuyo género se conoce, se extraen características y se entrena el clasificador
cancionConocida = cargarCanciones(0); %Matriz con todas las canciones (las filas son las canciones y las columnas el audio de uno de los canales - o la mezcla-).
caracteristicas = extraerCaract(cancion); %Matriz con las características (la fila representa la cancion)
%Se establecen los géneros de las canciones (conocidos):
%1: Rock  2: Clásica  3: Cumbia  4:Rap
generos = [4 2 1 3 2]; %ejemplo, cada elem se corresponde con una fila de la matriz de canciones
entrenarClasificador(caracteristicas,generos); %Debería devolver la red o clasificador entrenado

%2) Clasificación: Luego para cada canción (que no participa del entrenamiento) debo extraer características y pasarlas por el clasificador para obtener el género
cancionDescon = cargarCanciones(1);
clasificar(cancionDescon);
