# GRLDENV

Development environment for [grldchz](https://github.com/grldchz/grldchz-ts) and [grldservice](https://github.com/grldchz/grldservice)

### Get Started

* Install NodeJS
* Install Vagrant
* Install Virtual Box

Download git repositories

```
git clone https://github.com/grldchz/grldenv.git
cd grldenv
git clone https://github.com/grldchz/grldservice.git
git clone https://github.com/grldchz/grldchz-ts.git
cd ../
mkdir vendor
cd vendor
git clone https://github.com/PHPMailer/PHPMailer.git
cd ../
```

Build grldchz-ts

```
cd grldchz-ts
cp example.env .env
npm install
npm run build
cd ../
```

Configure grldservice

```
cd grldservice/lib
cp example.env .env
cd ../
```

Start up

```
cp example.env .env
vagrant up
```

[http://localhost/grldchz](http://localhost/grldchz)

To test changes made to grldchz-ts, simply `npm run build` again then refresh your browser.

To test changes made to grldservice, they are live as soon as you save a php file.