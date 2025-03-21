# Use the official OpenJDK image as the base image for Java development
FROM mcr.microsoft.com/devcontainers/java:21

# Set the working directory
WORKDIR /src

# Install dependencies and tools needed for Spring Boot development
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Maven globally (Spring Boot often uses Maven for dependency management)
RUN curl -fsSL https://apache.osuosl.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz -o /tmp/maven.tar.gz \
    && tar -xzf /tmp/maven.tar.gz -C /opt \
    && ln -s /opt/apache-maven-3.9.6 /opt/maven \
    && rm /tmp/maven.tar.gz

# Set Maven environment variables
ENV MAVEN_HOME=/opt/maven
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# Copy the Spring Boot project files into the container (assumes your project is in the current directory)
COPY . .

# Expose the default Spring Boot port
EXPOSE 8080

# Command to run when the container starts (you can override this in devcontainer.json if needed)
CMD ["/bin/bash"]