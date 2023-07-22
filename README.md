# Steganography Application using LSB Steganography

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [How to Use](#how-to-use)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- 
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

## Hosted on Microsoft Azure

🌐 Our Steganography Application is hosted on Microsoft Azure. You can access it using the following URL:

[https://steganoapp.azurewebsites.net/](https://steganoapp.azurewebsites.net/)

## How to Use

### Prerequisites

- Flutter SDK installed on your machine.
- Java Development Kit (JDK) installed.
- PostgreSQL database installed and running.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/steganography-app.git
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

![Landing Page](https://github.com/krishnapandey24/Stegano/assets/80609574/da191994-0da3-4200-915e-a59c507c808a)

🖼️ **Screenshot 2**: Encode Text - Interface for users to hide text inside images.

![Encode Text](https://github.com/krishnapandey24/Stegano/assets/80609574/eb2f637f-80b6-4c06-8233-9613215a4054)


🖼️ **Screenshot 3**: Decode Image - Interface for users to decode text from encoded images.

![Decode Image](https://github.com/krishnapandey24/Stegano/assets/80609574/e726c84f-901c-4bda-ac2e-5a3deed855ce)


## Contributing

🤝 Welcome contributors and explain how others can contribute to your project. You can provide guidelines for raising issues, creating pull requests, and setting up the development environment.

We welcome contributions from the community to enhance the functionality of our steganography application. To contribute, follow these steps:

1. Fork the repository and create a new branch.
2. Make changes and test them thoroughly.
3. Commit your changes with clear and concise messages.
4. Push your changes to your forked repository.
5. Create a pull request detailing the changes you made.

We appreciate your contributions and will review your pull requests as soon as possible.

## Acknowledgments

🙏 Show your gratitude to any third-party libraries, tools, or resources you used in your project. You can also thank any contributors or inspirations here.

- Acknowledge any libraries or frameworks you used.
- Thank any contributors who helped develop the application.
- Mention any tutorials or resources that inspired your work.
