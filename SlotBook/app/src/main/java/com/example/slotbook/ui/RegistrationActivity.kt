package com.example.slotbook.ui

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.example.slotbook.R
import com.example.slotbook.database.InterviewDatabase
import com.example.slotbook.model.User
import kotlinx.coroutines.launch

class RegistrationActivity : AppCompatActivity() {
    private lateinit var database: InterviewDatabase
    private lateinit var nameInput: EditText
    private lateinit var emailInput: EditText
    private lateinit var passwordInput: EditText
    private lateinit var registerButton: Button
    private lateinit var buttonBack: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registration)

        database = InterviewDatabase.getDatabase(this)

        nameInput = findViewById(R.id.etName)
        emailInput = findViewById(R.id.etEmail)
        passwordInput = findViewById(R.id.etPassword)
        registerButton = findViewById(R.id.btnRegister)
        buttonBack = findViewById(R.id.btnBack)

        registerButton.setOnClickListener {
            val name = nameInput.text.toString().trim()
            val email = emailInput.text.toString().trim()
            val password = passwordInput.text.toString().trim()

            if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
                Toast.makeText(this@RegistrationActivity, "Please fill all fields", Toast.LENGTH_SHORT).show()
            } else {
                lifecycleScope.launch {
                    val user = User(name = name, email = email, password = password)
                    database.userDao().insert(user)
                    runOnUiThread {
                        Toast.makeText(this@RegistrationActivity, "Registration successful", Toast.LENGTH_SHORT).show()
                    }
                    finish()
                }
            }
        }

        buttonBack.setOnClickListener{
            startActivity(Intent(this, LoginActivity::class.java))
        }
    }
}
