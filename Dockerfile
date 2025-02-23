# Escolha uma imagem base que tenha o JDK 8 e outras dependências
FROM openjdk:8-jdk-slim

# Instale dependências adicionais necessárias para o Android SDK
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libncurses5 \
    libssl1.0.0 \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Defina a variável de ambiente ANDROID_HOME
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

# Baixe e instale o Android SDK Command-Line Tools
RUN mkdir -p /opt/android-sdk/cmdline-tools && \
    curl -o /opt/android-sdk/cmdline-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip && \
    unzip /opt/android-sdk/cmdline-tools.zip -d /opt/android-sdk/cmdline-tools && \
    rm /opt/android-sdk/cmdline-tools.zip

# Aceite as licenças do SDK
RUN yes | sdkmanager --licenses

# Instalar as plataformas e ferramentas necessárias para a construção do APK
RUN sdkmanager --update
RUN sdkmanager "platform-tools" "build-tools;33.0.2" "platforms;android-34"

# Defina o diretório de trabalho para o projeto
WORKDIR /app

# Copie o código-fonte para o contêiner
COPY . /app

# Instale o Gradle, se necessário, ou use o Gradle wrapper (gradlew)
RUN ./gradlew --version

# Comando para construir o APK
CMD ["./gradlew", "assembleDebug"]
