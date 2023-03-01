package com.oti.team2.deliverable.service;

import java.util.List;

import com.oti.team2.deliverable.dto.Deliverable;

public interface IDeliverableService {

	List<Deliverable> getDeliverableList(String prgrsId);

	int addDeliverable(Deliverable deliverable);

	int deleteDeliverable(List<String> delivIdList);

}