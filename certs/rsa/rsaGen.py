import os
openssl_dir = os.path.expanduser('~/openssl')

myCmd = f'{openssl_dir}/apps/openssl req -x509 -new -newkey rsa -keyout key_CA.key -out key_CA.pem -pkeyopt rsa_keygen_bits:4096 -nodes -subj "/CN=oqstest CA" -days 365 -config {openssl_dir}/apps/openssl.cnf > /dev/null 2>&1 '
os.system(myCmd)
myCmd = f'{openssl_dir}/apps/openssl genpkey -algorithm rsa -out {openssl_dir}/lsquic/rsa/key_srv.pem -pkeyopt rsa_keygen_bits:4096 > /dev/null 2>&1'
os.system(myCmd)
myCmd = f'{openssl_dir}/apps/openssl req -new -key {openssl_dir}/lsquic/rsa/key_srv.pem -out {openssl_dir}/lsquic/rsa/key_srv.csr -nodes -pkeyopt rsa_keygen_bits:4096 -subj \'/CN=oqstest server\' -config {openssl_dir}/apps/openssl.cnf > /dev/null 2>&1'
os.system(myCmd)
myCmd = f'{openssl_dir}/apps/openssl x509 -req -in {openssl_dir}/lsquic/rsa/key_srv.csr -out {openssl_dir}/lsquic/rsa/key_crt.pem -CA key_CA.pem -CAkey key_CA.key -CAcreateserial -days 365' 
os.system(myCmd)