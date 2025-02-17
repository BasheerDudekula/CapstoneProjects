package com.example.slotbook.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.slotbook.R
import com.example.slotbook.model.Slot

class AvailableSlotsAdapter(
    private val slots: List<Slot>,
    private val onSlotClick: (Slot) -> Unit
) : RecyclerView.Adapter<AvailableSlotsAdapter.SlotViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SlotViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_available_slot, parent, false)
        return SlotViewHolder(view)
    }

    override fun onBindViewHolder(holder: SlotViewHolder, position: Int) {
        val slot = slots[position]
        holder.bind(slot)
    }

    override fun getItemCount(): Int {
        return slots.size
    }

    inner class SlotViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val slotTime: TextView = itemView.findViewById(R.id.textViewSlotTime)
        private val slotStatus: TextView = itemView.findViewById(R.id.textViewSlotStatus)

        fun bind(slot: Slot) {
            slotTime.text = slot.time
            slotStatus.text = if (slot.isBooked) "Booked" else "Available"
            itemView.setOnClickListener {
                onSlotClick(slot)
            }
        }
    }
}