set -e


REPO_URL="https://github.com/shibegora/shvirtd-example-python.git"
REPO_DIR="/opt/shvirtd-example-python"

echo "Обновление пакетов и установка зависимостей..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release software-properties-common

echo "Добавление GPG ключа Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "Добавление Docker репозитория..."
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

echo "Установка Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Добавление текущего пользователя в группу docker..."
sudo usermod -aG docker $USER

echo "Установка Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Проверка установленных версий Docker и Docker Compose..."
docker --version
docker-compose --version

echo "Клонирование репозитория в $REPO_DIR..."
sudo git clone $REPO_URL $REPO_DIR

cd $REPO_DIR

echo "Запуск Docker Compose..."
sudo docker compose -f compose.yaml -f proxy.yaml up -d --build

echo "Проект успешно запущен."

exit 0