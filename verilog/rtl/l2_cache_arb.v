//
// Determines whether a request from a core or a restarted request from
// the system memory interface queue should be pushed down the pipeline.
// The latter always has priority.
//

module l2_cache_arb(
	input						clk,
	input						stall_pipeline,
	input						pci_valid_i,
	output 						pci_ack_o,
	input [1:0]					pci_unit_i,
	input [1:0]					pci_strand_i,
	input [2:0]					pci_op_i,
	input [1:0]					pci_way_i,
	input [25:0]				pci_address_i,
	input [511:0]				pci_data_i,
	input [63:0]				pci_mask_i,
	input [1:0]					smq_pci_unit,				
	input [1:0]					smq_pci_strand,
	input [2:0]					smq_pci_op,
	input [1:0]					smq_pci_way,
	input [25:0]				smq_pci_address,
	input [511:0]				smq_pci_data,
	input [63:0]				smq_pci_mask,
	input [511:0] 				smq_load_buffer_vec,
	input						smq_data_ready,
	input [1:0]					smq_fill_way,
	output reg					arb_pci_valid = 0,
	output reg[1:0]				arb_pci_unit = 0,
	output reg[1:0]				arb_pci_strand = 0,
	output reg[2:0]				arb_pci_op = 0,
	output reg[1:0]				arb_pci_way = 0,
	output reg[25:0]			arb_pci_address = 0,
	output reg[511:0]			arb_pci_data = 0,
	output reg[63:0]			arb_pci_mask = 0,
	output reg					arb_has_sm_data = 0,
	output reg[511:0]			arb_sm_data = 0,
	output reg[1:0]				arb_sm_fill_way = 0);

	assign pci_ack_o = pci_valid_i && !stall_pipeline && !smq_data_ready;	

	always @(posedge clk)
	begin
		if (smq_data_ready)	
		begin
			arb_pci_valid <= #1 1'b1;
			arb_pci_unit <= #1 smq_pci_unit;
			arb_pci_strand <= #1 smq_pci_strand;
			arb_pci_op <= #1 smq_pci_op;
			arb_pci_way <= #1 smq_pci_way;
			arb_pci_address <= #1 smq_pci_address;
			arb_pci_data <= #1 smq_pci_data;
			arb_pci_mask <= #1 smq_pci_mask;
			arb_has_sm_data <= #1 1'b1;
			arb_sm_data <= #1 smq_load_buffer_vec;
			arb_sm_fill_way <= #1 smq_fill_way;
		end
		else
		begin
			arb_pci_valid <= #1 pci_valid_i;
			arb_pci_unit <= #1 pci_unit_i;
			arb_pci_strand <= #1 pci_strand_i;
			arb_pci_op <= #1 pci_op_i;
			arb_pci_way <= #1 pci_way_i;
			arb_pci_address <= #1 pci_address_i;
			arb_pci_data <= #1 pci_data_i;
			arb_pci_mask <= #1 pci_mask_i;
			arb_has_sm_data <= #1 0;
			arb_sm_data <= #1 0;
		end
	end
endmodule
