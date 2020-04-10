FROM nginx:latest

COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/

RUN adduser --quiet --gecos "phpkube,phpkube,0,0" --disabled-password --home /home/phpkube phpkube && bash -c 'mkdir -p /home/phpkube/{html/public,log,run,temp,var}' \
&& chown -Rf phpkube:phpkube /home/phpkube \
&& chown -Rf phpkube:phpkube /var/cache/nginx

RUN ln -sf /dev/stdout /home/phpkube/log/access.log  \
 && ln -sf /dev/stderr /home/phpkube/log/error.log 

COPY index.html /home/phpkube/html/public/

WORKDIR /home/phpkube/  

USER phpkube:phpkube

EXPOSE 8080
