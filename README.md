# AWS

# Iniciar laboratori

1. Accedir a l'Acadèmia d'AWS (https://www.awsacademy.com/) . 
2. Opció de menú LMS
3. Accedir als mòduls del curs: https://awsacademy.instructure.com/courses/86115/modules
4. Accedir al mòdul "Launch AWS Academy Learner Lab"
5. Accedir a l'opció de menú "Class"
6. Accedir a "Classes" i a l'opció dins del desplegable de Classes

![Desplegable classes](image-1.png)

7. Start Lab

# Instal·lació AWS CLI

Referència: 

[AWS CLI install and update instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

# Configurar les credencials d'accés 

## Consola del LAB

![image](https://github.com/projecteinf/AWS/assets/96139692/7765899b-a786-4f30-96c5-2d955ba50f52)

![image](https://github.com/projecteinf/AWS/assets/96139692/06388ef7-893b-4466-9184-d329e9ad0c35)

## Màquina local

En la màquina local (Linux) copiar el contingut del fitxer en la carpeta $HOME/.aws en un fitxer de nom "credentials"

![image](https://github.com/projecteinf/AWS/assets/96139692/85095981-689a-4154-9902-1b8eeee5802f)

![image](https://github.com/projecteinf/AWS/assets/96139692/f3d682bb-f797-4695-95bb-a4b15854c34b)

La clau del fitxer credentials es correspon al contingut del fitxer AWS CLI 

![image](https://github.com/projecteinf/AWS/assets/96139692/4b7b36ea-a7ad-49f9-85e3-df7597b83403)

ATENCIÓ : cada vegada que es tanca el laboratori i es torna a obrir, cal canviar el fitxer de credentials amb les noves credencials...
