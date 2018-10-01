
1) abrir la terminal y ejecutar la siguiente linea de código:
```
cd /home/estudiante/software; wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip; unzip hisat2-2.1.0-Linux_x86_64.zip
```

2) luego, ejecutar la siguiente línea de código:
```
cd ; sed -i '20s/^/#/' .zshrc ; sed -i '21s/^#//' .zshrc ; sed -i '31s/^/#/' .zshrc ; sed -i '32s/^/#/' .zshrc ; sed -i '189s/^/#/' .zshrc ; echo 'export PATH="/home/estudiante/software/hisat2-2.1.0:$PATH"' >> .zshrc
```

3) cerrar la terminal


4) volver a abrir la terminal y ejecutar la siguiente línea de código:
```
sudo apt install openmpi-bin abyss
```

5. HAGAN ESTO!
```
echo 'export PATH="/home/estudiante/software/hisat-0.1.6-beta:$PATH"' >> .zshrc
```
