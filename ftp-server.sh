docker run -d \
  --name pure-ftp \
  -p 21:21 \
  -p 30000-30009:30000-30009 \
  -e FTP_USER_NAME=ftpuser \
  -e FTP_USER_PASS=suasenha \
  -e FTP_USER_HOME=/home/ftpuser \
  -v $(pwd)/ftp_data:/home/ftpuser \
  stilliard/pure-ftpd:latest
