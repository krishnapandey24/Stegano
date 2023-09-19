# Stegano - Steganography Application using LSB Steganography

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [How to Use](#how-to-use)
- [Screenshots](#screenshots)
- [Contributing](#contributing)

## Introduction

📝 Steganography is the art of concealing information within a carrier medium, such as an image, audio, or video file, without attracting attention. The Least Significant Bit (LSB) steganography is a common technique where the least significant bit of each pixel in an image is replaced with bits of the secret message.

Our steganography application provides a user-friendly interface for users to hide text messages inside images using the LSB technique. Additionally, users have the option to encrypt the text before hiding it for added security. The application also allows users to decode text from an encoded image to retrieve hidden messages.

## Features

🚀 List the key features of your steganography application:

- Hide text messages inside images using LSB steganography.
- Encrypt text before embedding to enhance security.
- Decode hidden text from an encoded image.
- User authentication and authorization.
- Support for multiple image formats (e.g., PNG, JPEG).
- Intuitive and responsive user interface built with Flutter Web.
- Backend implementation using Spring Boot for efficient processing.
- Database storage using PostgreSQL for reliability and scalability.

## Technologies Used

🛠️ List the technologies and frameworks used in your project:

- Flutter Web: Frontend framework for building web applications.
- Spring Boot: Backend framework for Java applications.
- PostgreSQL: Open-source relational database management system.

## How to Use

### Prerequisites

- Flutter SDK installed on your machine.
- Java Development Kit (JDK) installed.
- PostgreSQL database installed and running.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/krishnapandey24/stegano.git
cd steganography-app
```

2. Frontend setup:

```bash
cd frontend
flutter packages get
flutter run
```

3. Backend setup:

```bash
cd backend
# Provide the necessary configuration in application.properties
./mvnw spring-boot:run
```

4. Database setup:

   - Create a PostgreSQL database and update the configuration in the backend.

5. Open your web browser and visit: `http://localhost:3000` to access the steganography application.

## Screenshots

📸 Add some screenshots of your application to showcase its functionality. Use emojis to describe each screenshot.

🖼️ **Screenshot 1**: Landing Page - The home page where users can get started.

![Landing Page](https://github.com/krishnapandey24/Stegano/assets/80609574/a8dde309-2e79-4526-a072-eba758e43479)

🖼️ **Screenshot 2**: Encode Text - Interface for users to hide text inside images.

![Screenshot (14)](https://github.com/krishnapandey24/Stegano/assets/80609574/c6130a95-2ce8-49bd-a81e-2f0e09c3e35c)


🖼️ **Screenshot 3**: Decode Image - Interface for users to decode text from encoded images.

![Screenshot (19)](https://github.com/krishnapandey24/Stegano/assets/80609574/f398ea7c-d745-4af4-ace2-96b93dc0093a)

🖼️ **Screenshot 4**: Decoded Image - Interface for users to see decoded text from encoded image after decoding it.

![Screenshot (17)](https://github.com/krishnapandey24/Stegano/assets/80609574/f3837fdc-4d9e-4ef1-8f99-e5fe73c6dca8)



## Contributing

🤝 Welcome contributors and explain how others can contribute to your project. You can provide guidelines for raising issues, creating pull requests, and setting up the development environment.

I welcome contributions from the community to enhance the functionality of our steganography application. To contribute, follow these steps:

1. Fork the repository and create a new branch.
2. Make changes and test them thoroughly.
3. Commit your changes with clear and concise messages.
4. Push your changes to your forked repository.
5. Create a pull request detailing the changes you made.

I appreciate your contributions and will review your pull requests as soon as possible.

