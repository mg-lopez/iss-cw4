FROM scratch
ADD export_h /
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
# Database Dockerfile



EXPOSE 3306
