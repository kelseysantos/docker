#! /bin/sh

set -e

if [ "${MC_HOST_SOURCE}" == "**None**" ]; then
  echo "Error: Voce nao colocou os parametros corretos em MC_HOST_SOURCE."
  exit 1
fi

if [ "${MC_HOST_DESTINATION}" == "**None**" ]; then
  echo "Error: Voce nao colocou os parametros corretos em MC_HOST_SOURCE."
  exit 1
fi

mirror_s3 () {
  SOURCE_STORAGE=$1
  DESTINATION_STORAGE=$2

  echo "Espelho dos Buckets de ${SOURCE_STORAGE} para ${DESTINATION_STORAGE}..."

  mc mirror --watch SOURCE DESTINATION

  if [ $? != 0 ]; then
    >&2 echo "Error ao migrar arquivos de ${SOURCE_STORAGE} para ${DESTINATION_STORAGE}!"
  fi

}
 
mirror_s3 $MC_HOST_SOURCE $MC_HOST_DESTINATION