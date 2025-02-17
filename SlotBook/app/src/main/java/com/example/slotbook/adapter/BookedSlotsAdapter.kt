package com.example.slotbook.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.model.BookedSlot

class BookedSlotsAdapter(
    private val bookedSlots: List<BookedSlot>,
    private val onItemClick: (BookedSlot) -> Unit
) : RecyclerView.Adapter<BookedSlotsAdapter.BookedSlotViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BookedSlotViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_booked_slot, parent, false)
        return BookedSlotViewHolder(view)
    }

    override fun onBindViewHolder(holder: BookedSlotViewHolder, position: Int) {
        val bookedSlot = bookedSlots[position]
        holder.bind(bookedSlot)
    }

    override fun getItemCount(): Int = bookedSlots.size

    inner class BookedSlotViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val slotTimeTextView: TextView = itemView.findViewById(R.id.textViewSlotTime)
        private val interviewerNameTextView: TextView = itemView.findViewById(R.id.textViewInterviewerName)

        fun bind(bookedSlot: BookedSlot) {
            slotTimeTextView.text = bookedSlot.slotTime
            interviewerNameTextView.text = bookedSlot.interviewerName
            itemView.setOnClickListener {
                onItemClick(bookedSlot)
            }
        }
    }
}