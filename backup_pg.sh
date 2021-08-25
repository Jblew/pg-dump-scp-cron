set +x
set -e
DUMP_FILE_NAME="dump_$(date +"%Y_%m_%d_%I_%M_%p").sql"
echo "Begin pg_dump to ${DUMP_FILE_NAME}"


PGPASSWORD="${DB_PASS}" \
pg_dump \
 --host ${DB_HOST} \
 --port ${DB_PORT} \
 --username ${DB_USER} \
 ${DB_NAME} \
 > \
"${DUMP_FILE_NAME}"

echo "Done pg_dump"

echo "Begin uploading $DUMP_FILE_NAME database dump via scp"
sshpass -p "${SSH_PASSWORD}" scp -oStrictHostKeyChecking=no -P "${SSH_PORT}" "${DUMP_FILE_NAME}" "${SSH_UPLOAD_PATH}/dump.sql"
echo "Done uploading"

# TODO: best host this image outside of this repo. This is an irrelevant lib — it does not need any 1my related config.