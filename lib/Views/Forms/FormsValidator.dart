import 'package:flutter/material.dart';

loginFormValidator(
  TextEditingController username,
  TextEditingController password
){
  if (username.text.toString().trim() == "") {
      return "Username is required";
  } else if (password.text.toString().trim() == "") {
      return "Password is required";
  }else {
    return null;
  }
}

companyFormValidator(
    TextEditingController companyName,
    TextEditingController companyUserName,
    TextEditingController companyEmail,
    TextEditingController companyPassword,
    TextEditingController companyConfirmPassword,
    TextEditingController companyTel,
    TextEditingController companyCell,
    TextEditingController companyAddress1,
    TextEditingController companyAddress2,
    TextEditingController companyCity,
    TextEditingController companyCountry,
  ) {
    if (companyName.text.toString().trim() == null) {
      return "Company name is empty";
    } else if (companyUserName.text.toString().trim() == null) {
      return "Company Username is empty";
    } else if (companyEmail.text.toString().trim() == null) {
      return "Email is empty";
    } else if (companyPassword.text.toString().trim() == null) {
      return "Password is empty";
    } else if (companyConfirmPassword.text.toString().trim() == null) {
      return "Password Confirmation is empty";
    } else if (companyTel.text.toString().trim() == null) {
      return "Company Tel is empty";
    } else if (companyCell.text.toString().trim() == null) {
      return "Company Cell is empty";
    } else if (companyAddress1.text.toString().trim() == null) {
      return "Company Address 1 is empty";
    } else if (companyAddress2.text.toString().trim() == null) {
      return "Company Address 2 is empty";
    } else if (companyCity.text == null) {
      return "City is empty";
    } else if (companyUserName.text.toString().trim() == null) {
      return "Country is empty";
    } else {
      return null;
    }
  }

  formValidator(
      TextEditingController username,
      TextEditingController fName,
      TextEditingController lName,
      TextEditingController email,
      TextEditingController country,
      TextEditingController pass1,
      TextEditingController pass2) {
    if (username.text.trim().isEmpty || username.text == "") {
      return "username is required";
    } else if (fName.text.trim().isEmpty || fName.text == "") {
      return "firstname is required";
    } else if (lName.text.trim().isEmpty || lName.text == "") {
      return "lastname is required";
    } else if (email.text.trim().isEmpty || email.text == "") {
      return "email is required";
    } else if (country.text.isEmpty || country.text == "") {
      return "country is required";
    } else if (pass1.text.trim().isEmpty || pass1.text == "") {
      return "password is required";
    } else if (pass2.text.trim().isEmpty || pass2.text == "") {
      return "password confirmation is required";
    } else {
      return null;
    }
  }