package kr.ne.abc.bts.template.board.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class Board {
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String age;
    private String name;
    
    public Board() {
    }
    
    public Board(String name, String age) {
        this.name = name;
        this.age = age;
    }
}
